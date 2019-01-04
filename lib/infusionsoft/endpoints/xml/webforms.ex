defmodule Infusionsoft.Endpoints.XML.Weborms do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Funnel actions.
  """
  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#webform-retrieve-a-form-s-html"
  @spec retrieve_form_html(integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_form_html(id, token, app \\ nil) do
    params = Helpers.build_params([id], token, app)
    Helpers.process_endpoint("WebFormService.getHTML", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#webform-retrieve-webform-ids"
  @spec retrieve_webforms(String.t(), nil | String.t()) :: {:ok, list()} | {:error, String.t()}
  def retrieve_webforms(token, app \\ nil) do
    params = Helpers.build_params(nil, token, app)
    Helpers.process_endpoint("WebFormService.getMap", params, token, app)
  end
end
