defmodule Infusionsoft.Caches.Companies do
  @moduledoc false

  # Manages the cache for companies.

  # The update task runs every 15 minutes, and gets the most recent list of
  # companies from Infusionsoft for every API token that's been used in
  # the app and is still valid.

  use GenServer

  alias Infusionsoft.Endpoints.XML.Data

  # Client API

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @doc "The first argument can be either the company Id or Name."
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
        with {:ok, companies} <- get_companies(token, app) do
          state = Map.put(state, token, %{token: token, app: app, companies: companies})

          {:reply, check_company(companies, identifier), state}
        else
          {:error, error} ->
            {:reply, {:error, "Failed to get companies with error: #{error}"}, state}

          _ ->
            {:reply, {:error, "Unexpected error occurred getting companies"}, state}
        end

      group ->
        {:reply, check_company(group.companies, identifier), state}
    end
  end

  def handle_info(:refresh, state) do
    state =
      for {token, group} <- state do
        with {:ok, companies} <- get_companies(token, group.app) do
          %{token: token, app: group.app, companies: companies}
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

  defp get_companies(token, app) do
    query = %{"Id" => "%"}
    return_fields = ["Id", "Company"]

    response = Data.query_a_data_table("Company", query, return_fields, token, app)

    with {:ok, companies} <- response do
      # Duplicate the field list by Name and Id so that access is
      # available translating from Common to XML / REST, and vice versa
      companies_by_name = group_by_name(companies)
      companies_by_id = group_by_id(companies)

      {:ok, Map.merge(companies_by_name, companies_by_id)}
    end
  end

  defp group_by_name(companies) do
    Enum.group_by(companies, fn c -> String.downcase(c["Company"]) end)
  end

  defp group_by_id(companies) do
    Enum.group_by(companies, fn c -> c["Id"] end)
  end

  defp check_company(custom_fields, identifier)

  defp check_company(companies, id) when is_integer(id) do
    case companies[id] do
      nil -> {:error, ~s|No company with id #{id} exists|}
      [company] -> {:ok, company}
      _any -> {:error, ~s|Company with id #{id} exists more than once|}
    end
  end

  defp check_company(companies, name) when is_binary(name) do
    case companies[String.downcase(name)] do
      nil -> {:error, ~s|No company "#{name}" exists|}
      [company] -> {:ok, company}
      _any -> {:error, ~s|Company "#{name}" exists more than once|}
    end
  end

  defp check_company(_, name) do
    {:error, "Invalid type: #{inspect(name)}"}
  end
end
