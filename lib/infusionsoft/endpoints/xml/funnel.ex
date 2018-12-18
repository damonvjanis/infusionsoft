defmodule Infusionsoft.Endpoints.XML.Funnel do
  @moduledoc """
  Provides the endpoints to Infusionsoft's XML API for Funnel actions.
  """
  alias Infusionsoft.Endpoints.XML

  def achieve_goal(contact_id, integration_name, call_name, token) do
    params = ["", integration_name, call_name, contact_id]
    XML.process_endpoint("FunnelService.achieveGoal", params, token)
  end
end
