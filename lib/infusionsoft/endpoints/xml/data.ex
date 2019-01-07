defmodule Infusionsoft.Endpoints.XML.Data do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Data actions.
  """
  alias Infusionsoft.Endpoints.XML.Helpers

  @doc """
  https://developer.infusionsoft.com/docs/xml-rpc/#data-query-a-data-table

  Available options:
  page - defaults to 0
  limit - defaults to 1000
  order_by - defualts to Id
  ascending - defaults to false
  """
  @spec query_table(map(), String.t(), [String.t()], String.t(), nil | String.t(), keyword()) ::
          {:ok, list()} | {:error, String.t()}
  def query_table(query, table, return_fields, token, app, opts \\ []) do
    opts = Keyword.merge([page: 0, limit: 1000, order_by: "Id", ascending: false], opts)
    page = Keyword.fetch!(opts, :page)
    limit = Keyword.fetch!(opts, :limit)
    order_by = Keyword.fetch!(opts, :order_by)
    asc = Keyword.fetch!(opts, :ascending)

    params =
      Helpers.build_params([table, limit, page, query, return_fields, order_by, asc], token, app)

    Helpers.process_endpoint("DataService.query", params, token, app)
  end

  @doc """
  Helper to recurse and get the full number of records instead of one page

  https://developer.infusionsoft.com/docs/xml-rpc/#data-query-a-data-table

  Available options:
  order_by - defualts to Id
  ascending - defaults to false
  """
  @spec query_all_from_table(
          map(),
          String.t(),
          [String.t()],
          String.t(),
          nil | String.t(),
          keyword()
        ) :: {:ok, list()} | {:error, String.t()}
  def query_all_from_table(query, table, r_fields, token, app, opts \\ []) do
    do_query_all_from_table(query, table, r_fields, token, app, opts, 0, [], [])
  end

  defp do_query_all_from_table(_, _, _, _, _, _, count, acc, []) when count != 0 do
    {:ok, acc}
  end

  defp do_query_all_from_table(query, table, r_fields, token, app, opts, count, acc, new) do
    opts = Keyword.merge(opts, page: count, limit: 1000)

    with {:ok, next} <- query_table(query, table, r_fields, token, app, opts) do
      current = acc ++ new
      count = count + 1
      opts = Keyword.merge(opts, page: count, limit: 1000)
      do_query_all_from_table(query, table, r_fields, token, app, opts, count, current, next)
    end
  end

  @doc """
  https://developer.infusionsoft.com/docs/xml-rpc/#data-find-a-record-by-matching-a-specific-field

  Available options:
  page - defaults to 0
  limit - defaults to 1000
  """
  @spec find_by_field(
          String.t(),
          String.t(),
          String.t(),
          [String.t()],
          String.t(),
          nil | String.t(),
          keyword()
        ) :: {:ok, list()} | {:error, String.t()}
  def find_by_field(value, field, table, return_fields, token, app, opts \\ []) do
    opts = Keyword.merge([page: 0, limit: 1000], opts)
    page = Keyword.fetch!(opts, :page)
    limit = Keyword.fetch!(opts, :limit)

    params = Helpers.build_params([table, limit, page, field, value, return_fields], token, app)

    Helpers.process_endpoint("DataService.findByField", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#data-create-a-record"
  @spec create_record(map(), String.t(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, String.t()}
  def create_record(data, table, token, app \\ nil) do
    params = Helpers.build_params([table, data], token, app)
    Helpers.process_endpoint("DataService.add", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#data-retrieve-a-record"
  @spec retrieve_record(integer(), String.t(), [String.t()], String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, String.t()}
  def retrieve_record(id, table, fields, token, app \\ nil) do
    params = Helpers.build_params([table, id, fields], token, app)
    Helpers.process_endpoint("DataService.load", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#data-update-a-record"
  @spec update_record(map(), integer(), String.t(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, String.t()}
  def update_record(data, id, table, token, app \\ nil) do
    params = Helpers.build_params([table, id, data], token, app)
    Helpers.process_endpoint("DataService.update", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#data-delete-a-record"
  @spec delete_record(integer(), String.t(), String.t(), nil | String.t()) ::
          {:ok, boolean()} | {:error, String.t()}
  def delete_record(id, table, token, app \\ nil) do
    params = Helpers.build_params([table, id], token, app)
    Helpers.process_endpoint("DataService.delete", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#data-count-a-data-table-s-records"
  @spec count_records(map(), String.t(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, String.t()}
  def count_records(data, table, token, app \\ nil) do
    params = Helpers.build_params([table, data], token, app)
    Helpers.process_endpoint("DataService.count", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#data-create-a-custom-field"
  @spec create_custom_field(
          String.t(),
          String.t(),
          String.t(),
          integer(),
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, String.t()}
  def create_custom_field(name, table, type, header, token, app \\ nil) do
    params = Helpers.build_params([table, name, type, header], token, app)
    Helpers.process_endpoint("DataService.addCustomField", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#data-update-a-custom-field"
  @spec update_custom_field(integer(), map(), String.t(), nil | String.t()) ::
          {:ok, boolean()} | {:error, String.t()}
  def update_custom_field(id, data, token, app \\ nil) do
    params = Helpers.build_params([id, data], token, app)
    Helpers.process_endpoint("DataService.updateCustomField", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#data-retrieve-an-appointment-s-icalendar-file"
  @spec retrieve_appt_ical(integer(), String.t(), nil | String.t()) ::
          {:ok, String.t()} | {:error, String.t()}
  def retrieve_appt_ical(id, token, app \\ nil) do
    params = Helpers.build_params([id], token, app)
    Helpers.process_endpoint("DataService.getAppointmentICal", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#data-retrieve-application-setting"
  @spec retrieve_app_settings(String.t(), String.t(), String.t(), nil | String.t()) ::
          {:ok, String.t()} | {:error, String.t()}
  def retrieve_app_settings(module, setting, token, app \\ nil) do
    params = Helpers.build_params([module, setting], token, app)
    Helpers.process_endpoint("DataService.getAppSetting", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#data-validate-a-user-s-credentials"
  @spec authenticate_user(String.t(), String.t(), String.t(), nil | String.t()) ::
          {:ok, integer() | String.t()} | {:error, String.t()}
  def authenticate_user(username, password_hash, token, app \\ nil) do
    params = Helpers.build_params([username, password_hash], token, app)
    Helpers.process_endpoint("DataService.authenticateUser", params, token, app)
  end
end
