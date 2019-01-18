defmodule Infusionsoft.Endpoints.XML.AffiliateProgram do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Affiliate Program.
  """

  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#affiliate-program-retrieve-all-programs"
  @spec retrieve_all_programs(String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_all_programs(token, app \\ nil) do
    params = Helpers.build_params(nil, token, app)
    Helpers.process_endpoint("AffiliateProgramService.getAffiliatePrograms", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#affiliate-program-retrieve-a-program-s-affiliates"
  @spec retrieve_a_programs_affiliates(integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_a_programs_affiliates(program_id, token, app \\ nil) do
    params = Helpers.build_params([program_id], token, app)
    Helpers.process_endpoint("AffiliateProgramService.getAffiliatesByProgram", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#affiliate-program-retrieve-an-affiliate-s-programs"
  @spec retrieve_an_affiliates_programs(integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_an_affiliates_programs(affiliate_id, token, app \\ nil) do
    params = Helpers.build_params([affiliate_id], token, app)

    Helpers.process_endpoint(
      "AffiliateProgramService.getProgramsForAffiliate",
      params,
      token,
      app
    )
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#affiliate-program-retrieve-program-resources"
  @spec retrieve_program_resources(integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_program_resources(program_id, token, app \\ nil) do
    params = Helpers.build_params([program_id], token, app)

    Helpers.process_endpoint(
      "AffiliateProgramService.getResourcesForAffiliateProgram",
      params,
      token,
      app
    )
  end
end
