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

  @doc "The first argument can be either the custom field Id, Name, or Label."
  @spec lookup(String.t() | integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, binary()}
  def lookup(identifier, token, app \\ nil) do
    GenServer.call(__MODULE__, {:lookup, token, app, identifier})
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

  def handle_call({:lookup, token, app, identifier}, _from, state) do
    case state[token] do
      nil ->
        with {:ok, fields} <- get_fields(token, app) do
          state = Map.put(state, token, %{token: token, app: app, custom_fields: fields})

          {:reply, check_field(fields, identifier), state}
        else
          {:error, error} ->
            {:reply, {:error, "Failed to get contact custom fields with error: #{error}"}, state}
        end

      group ->
        {:reply, check_field(group.custom_fields, identifier), state}
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
          _ -> nil
        end
      end
      |> Enum.filter(& &1)
      |> Enum.group_by(fn g -> g.token end)
      |> Enum.into(%{}, fn {token, [group]} -> {token, group} end)

    schedule_next_job()
    {:noreply, state}
  end

  # Ignores when HTTP clients send info messages about connections closed
  def handle_info(_, state) do
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

    response = Data.query_a_data_table("DataFormField", query, return_fields, token, app)

    with {:ok, fields} <- response do
      # Duplicate the field list by Name, Label, and Id so that access is
      # available translating from Common to XML / REST, and vice versa
      fields_by_name = group_by_name(fields)
      fields_by_label = group_by_label(fields)
      fields_by_id = group_by_id(fields)

      {:ok, fields_by_name |> Map.merge(fields_by_label) |> Map.merge(fields_by_id)}
    end
  end

  defp group_by_name(fields) do
    # Add underscore so that XML name will match
    Enum.group_by(fields, fn f -> "_" <> String.downcase(f["Name"]) end)
  end

  defp group_by_label(fields) do
    Enum.group_by(fields, fn f -> String.downcase(f["Label"]) end)
  end

  defp group_by_id(fields) do
    Enum.group_by(fields, fn f -> f["Id"] end)
  end

  defp check_field(custom_fields, identifier)

  defp check_field(custom_fields, id) when is_integer(id) do
    case custom_fields[id] do
      nil -> {:error, ~s|No contact custom field with id #{id} exists|}
      [field] -> {:ok, field}
      _any -> {:error, ~s|Field with id #{id} exists more than once|}
    end
  end

  defp check_field(custom_fields, name) when is_binary(name) do
    case custom_fields[String.downcase(name)] do
      nil -> {:error, ~s|No contact custom field "#{name}" exists|}
      [field] -> {:ok, field}
      _any -> {:error, ~s|Field "#{name}" exists more than once|}
    end
  end

  defp check_field(_, name) do
    {:error, "Invalid type: #{inspect(name)}"}
  end
end

# TODO
# The cache should eventually accomodate multiple custom fields with the same name, when they have
# a different Tab (Group). For now, we will return an error if a custom field is looked up
# and there are multiple custom fields with the same display name.
