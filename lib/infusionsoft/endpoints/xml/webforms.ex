defmodule Infusionsoft.Endpoints.XML.Webform do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Webform actions.
  """
  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#webform-retrieve-a-form-s-html"
  @spec retrieve_a_forms_html(integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_a_forms_html(form_id, token, app \\ nil) do
    params = Helpers.build_params([form_id], token, app)
    Helpers.process_endpoint("WebFormService.getHTML", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#webform-retrieve-webform-ids"
  @spec retrieve_webform_ids(String.t(), nil | String.t()) :: {:ok, list()} | {:error, String.t()}
  def retrieve_webform_ids(token, app \\ nil) do
    params = Helpers.build_params(nil, token, app)
    Helpers.process_endpoint("WebFormService.getMap", params, token, app)
  end
end
