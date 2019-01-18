defmodule Infusionsoft.Endpoints.XML.Funnel do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Funnel actions.
  """
  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#funnel-achieve-a-goal"
  @spec achieve_a_goal(String.t(), String.t(), integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def achieve_a_goal(integration, call_name, contact_id, token, app \\ nil) do
    params = Helpers.build_params([integration, call_name, contact_id], token, app)
    Helpers.process_endpoint("FunnelService.achieveGoal", params, token, app)
  end
end
