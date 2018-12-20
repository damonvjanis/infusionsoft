defmodule Infusionsoft.Endpoints.XML.Funnel do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Funnel actions.
  """
  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#funnel-achieve-a-goal"
  @spec achieve_goal(integer(), String.t(), String.t(), String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def achieve_goal(contact_id, integration_name, call_name, token) do
    params = ["", integration_name, call_name, contact_id]
    Helpers.process_endpoint("FunnelService.achieveGoal", params, token)
  end
end
