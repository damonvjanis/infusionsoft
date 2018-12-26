defmodule Infusionsoft.Endpoints.XML.Data do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Funnel actions.
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
end
