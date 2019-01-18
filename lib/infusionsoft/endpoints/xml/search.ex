defmodule Infusionsoft.Endpoints.XML.Search do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Search.
  """

  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#search-retrieve-a-report-s-available-fields"
  @spec retrieve_available_fields(integer(), integer() | String.t(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, any()}
  def retrieve_available_fields(saved_search_id, user_id, token, app \\ nil) do
    params = Helpers.build_params([saved_search_id, user_id], token, app)
    Helpers.process_endpoint("SearchService.getAllReportColumns", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#search-retrieve-a-complete-report-from-a-saved-search"
  @spec retrieve_search_report(
          integer(),
          integer() | String.t(),
          integer(),
          String.t(),
          nil | String.t()
        ) :: {:ok, list()} | {:error, any()}
  def retrieve_search_report(saved_search_id, user_id, page_number, token, app \\ nil) do
    params = Helpers.build_params([saved_search_id, user_id, page_number], token, app)
    Helpers.process_endpoint("SearchService.getSavedSearchResultsAllFields", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#search-retrieve-a-partial-report-from-a-saved-search"
  @spec retrieve_partial_report(
          integer(),
          integer() | String.t(),
          integer(),
          [String.t()],
          String.t(),
          nil | String.t()
        ) :: {:ok, list()} | {:error, any()}
  def retrieve_partial_report(
        saved_search_id,
        user_id,
        page_number,
        return_fields,
        token,
        app \\ nil
      ) do
    params =
      Helpers.build_params([saved_search_id, user_id, page_number, return_fields], token, app)

    Helpers.process_endpoint("SearchService.getSavedSearchResults", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#search-retrieve-available-quick-searches"
  @spec retrieve_available_quick_searches(integer() | String.t(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, any()}
  def retrieve_available_quick_searches(user_id, token, app \\ nil) do
    params = Helpers.build_params([user_id], token, app)
    Helpers.process_endpoint("SearchService.getAvailableQuickSearches", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#search-retrieve-the-default-quick-search"
  @spec retrieve_default_quick_search(integer() | String.t(), String.t(), nil | String.t()) ::
          {:ok, any()} | {:error, any()}
  def retrieve_default_quick_search(user_id, token, app \\ nil) do
    params = Helpers.build_params([user_id], token, app)
    Helpers.process_endpoint("SearchService.getDefaultQuickSearch", params, token, app)
  end

  @doc """
  https://developer.infusionsoft.com/docs/xml-rpc/#search-retrieve-a-quick-search-report

  Available options:
  page - defaults to 0
  limit - defaults to 1000
  """
  @spec retrieve_quick_search(
          String.t(),
          integer() | String.t(),
          String.t(),
          String.t(),
          nil | String.t(),
          keyword()
        ) :: {:ok, list()} | {:error, any()}
  def retrieve_quick_search(search_type, user_id, search_data, token, app, opts \\ []) do
    opts = Keyword.merge([page: 0, limit: 1000], opts)
    page = Keyword.fetch!(opts, :page)
    limit = Keyword.fetch!(opts, :limit)

    params = Helpers.build_params([search_type, user_id, search_data, page, limit], token, app)
    Helpers.process_endpoint("SearchService.quickSearch", params, token, app)
  end
end
