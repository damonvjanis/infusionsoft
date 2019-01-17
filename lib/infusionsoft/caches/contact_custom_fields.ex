defmodule Infusionsoft.Caches.ContactCustomFields do
  @moduledoc false

  # Manages the cache for contact custom fields.

  # The update task runs every 15 minutes, and gets the most recent list of
  # custom fields from Infusionsoft for every API token that's been used in
  # the app and is still valid.

  use GenServer

  alias Infusionsoft.Endpoints.XML.Data

  # Client API

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @spec lookup(atom(), String.t(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, binary()}
  def lookup(pid, name, token, app) do
    GenServer.call(pid, {:lookup, token, app, name})
  end

  # Server API

  def init(state) do
    if enabled?() do
      schedule_initial_job()
      {:ok, state}
    else
      :ignore
    end
  end

  def handle_call({:lookup, token, app, name}, _from, state) do
    case state[token] do
      nil ->
        with {:ok, fields} <- get_fields(token, app) do
          state = Map.put(state, token, %{token: token, app: app, custom_fields: fields})

          {:reply, check_field(fields, name), state}
        else
          {:error, error} ->
            {:reply, {:error, "Failed to get contact custom fields with error: #{error}"}, state}

          _ ->
            {:reply, {:error, "Unexpected error occurred getting contact custom fields"}, state}
        end

      group ->
        {:reply, check_field(group.custom_fields, name), state}
    end
  end

  def handle_info(:refresh, state) do
    state =
      for {token, group} <- state do
        with {:ok, fields} <- get_fields(token, group.app) do
          %{token: token, app: group.app, custom_fields: fields}
        else
          # With these named errors, don't remove the token from state
          {:error, "timeout"} -> state[token]
          {:error, "closed"} -> state[token]
          {:error, "connect_timeout"} -> state[token]
          _ -> nil
        end
      end
      |> Enum.filter(& &1)
      |> Enum.group_by(fn g -> g.token end)
      |> Enum.into(%{}, fn {token, [group]} -> {token, group} end)

    schedule_next_job()
    {:noreply, state}
  end

  defp schedule_initial_job() do
    # In 5 seconds
    Process.send_after(self(), :refresh, 5_000)
  end

  defp schedule_next_job() do
    # In 15 minutes
    Process.send_after(self(), :refresh, 15 * 60 * 1000)
  end

  defp enabled?() do
    not (Application.get_env(:infusionsoft, __MODULE__)[:enabled] == false)
  end

  defp get_fields(token, app) do
    # Get the custom fields where FormID is -1, which identifies Contact custom fields
    query = %{"FormID" => -1}
    return_fields = ["GroupId", "Id", "Label", "Name"]

    with {:ok, fields} <-
           Data.query_a_data_table(query, "DataFormField", return_fields, token, app) do
      # Duplicate the field list to be grouped by Name and again by Label
      # so that access is available translating from Common to XML and vice versa
      {:ok, Map.merge(group_by_name(fields), group_by_label(fields))}
    end
  end

  defp group_by_name(fields) do
    # Add underscore so that XML name will match
    Enum.group_by(fields, fn f -> "_" <> String.downcase(f["Name"]) end)
  end

  defp group_by_label(fields) do
    Enum.group_by(fields, fn f -> String.downcase(f["Label"]) end)
  end

  defp check_field(custom_fields, name) do
    case custom_fields[String.downcase(name)] do
      nil -> {:error, ~s|No contact custom field "#{name}" exists|}
      [field] -> {:ok, field}
      _any -> {:error, ~s|Field "#{name}" exists more than once|}
    end
  end
end

# The cache should eventually accomodate multiple custom fields with the same name, when they have
# a different Tab and Header. For now, we will return an error if a custom field is looked up
# and there are multiple custom fields with the same display name.
