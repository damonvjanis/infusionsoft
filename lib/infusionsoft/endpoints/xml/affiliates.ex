defmodule Infusionsoft.Endpoints.XML.Affiliate do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Affiliate.
  """

  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#affiliate-retrieve-clawbacks"
  @spec retrieve_clawbacks(integer(), %Date{}, %Date{}, String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_clawbacks(affiliate_id, filter_start_date, filter_end_date, token, app \\ nil) do
    start_date = start_to_xml_iso(filter_start_date)
    end_date = end_to_xml_iso(filter_end_date)

    params = Helpers.build_params([affiliate_id, start_date, end_date], token, app)
    Helpers.process_endpoint("APIAffiliateService.affClawbacks", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#affiliate-retrieve-commissions"
  @spec retrieve_commissions(integer(), %Date{}, %Date{}, String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_commissions(affiliate_id, filter_start_date, filter_end_date, token, app \\ nil) do
    start_date = start_to_xml_iso(filter_start_date)
    end_date = end_to_xml_iso(filter_end_date)

    params = Helpers.build_params([affiliate_id, start_date, end_date], token, app)
    Helpers.process_endpoint("APIAffiliateService.affCommissions", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#affiliate-retrieve-payments"
  @spec retrieve_payments(integer(), %Date{}, %Date{}, String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_payments(affiliate_id, filter_start_date, filter_end_date, token, app \\ nil) do
    start_date = start_to_xml_iso(filter_start_date)
    end_date = end_to_xml_iso(filter_end_date)

    params = Helpers.build_params([affiliate_id, start_date, end_date], token, app)
    Helpers.process_endpoint("APIAffiliateService.affPayouts", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#affiliate-retrieve-redirect-links"
  @spec retrieve_redirect_links(integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_redirect_links(affiliate_id, token, app \\ nil) do
    params = Helpers.build_params([affiliate_id], token, app)
    Helpers.process_endpoint("AffiliateService.getRedirectLinksForAffiliate", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#affiliate-retrieve-a-summary-of-affiliate-statistics"
  @spec retrieve_summary([integer()], %Date{}, %Date{}, String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_summary(affiliate_ids, filter_start_date, filter_end_date, token, app \\ nil) do
    start_date = start_to_xml_iso(filter_start_date)
    end_date = end_to_xml_iso(filter_end_date)

    params = Helpers.build_params([affiliate_ids, start_date, end_date], token, app)
    Helpers.process_endpoint("APIAffiliateService.affSummary", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#affiliate-retrieve-running-totals"
  @spec retrieve_running_totals([integer()], String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def retrieve_running_totals(affiliate_ids, token, app \\ nil) do
    params = Helpers.build_params([affiliate_ids], token, app)
    Helpers.process_endpoint("APIAffiliateService.affRunningTotals", params, token, app)
  end

  defp start_to_xml_iso(%Date{} = date), do: XMLRPC.DateTime.new({Date.to_erl(date), {0, 0, 0}})
  defp end_to_xml_iso(%Date{} = date), do: XMLRPC.DateTime.new({Date.to_erl(date), {23, 59, 59}})
end
