defmodule Infusionsoft.Endpoints.XML.AffiliatePrograms do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Affiliate Programs.
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
  @spec retrieve_program_affiliates(integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_program_affiliates(id, token, app \\ nil) do
    params = Helpers.build_params([id], token, app)
    Helpers.process_endpoint("AffiliateProgramService.getAffiliatesByProgram", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#affiliate-program-retrieve-an-affiliate-s-programs"
  @spec retrieve_affiliate_programs(integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_affiliate_programs(id, token, app \\ nil) do
    params = Helpers.build_params([id], token, app)

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
  def retrieve_program_resources(id, token, app \\ nil) do
    params = Helpers.build_params([id], token, app)

    Helpers.process_endpoint(
      "AffiliateProgramService.getResourcesForAffiliateProgram",
      params,
      token,
      app
    )
  end
end
