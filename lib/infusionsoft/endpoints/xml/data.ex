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
end
