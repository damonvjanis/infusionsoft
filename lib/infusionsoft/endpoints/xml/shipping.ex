defmodule Infusionsoft.Endpoints.XML.Shipping do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Shipping.
  """

  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#shipping-retrieve-available-shipping-options"
  @spec retrieve_available_shipping_options(String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, any()}
  def retrieve_available_shipping_options(token, app \\ nil) do
    params = Helpers.build_params(nil, token, app)
    Helpers.process_endpoint("ShippingService.getAllShippingOptions", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#shipping-retrieve-weight-based-shipping-options"
  @spec retrieve_weight_based_shipping_options(integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, any()}
  def retrieve_weight_based_shipping_options(option_id, token, app \\ nil) do
    params = Helpers.build_params([option_id], token, app)
    Helpers.process_endpoint("ShippingService.getWeightBasedShippingOption", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#shipping-retrieve-flat-rate-shipping-options"
  @spec retrieve_flat_rate_shipping_options(integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, any()}
  def retrieve_flat_rate_shipping_options(option_id, token, app \\ nil) do
    params = Helpers.build_params([option_id], token, app)
    Helpers.process_endpoint("ShippingService.getFlatRateShippingOption", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#shipping-retrieve-product-shipping-options"
  @spec retrieve_product_shipping_options(integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, any()}
  def retrieve_product_shipping_options(option_id, token, app \\ nil) do
    params = Helpers.build_params([option_id], token, app)
    Helpers.process_endpoint("ShippingService.getProductBasedShippingOption", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#shipping-retrieve-order-shipping-options"
  @spec retrieve_order_shipping_options(integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, any()}
  def retrieve_order_shipping_options(option_id, token, app \\ nil) do
    params = Helpers.build_params([option_id], token, app)
    Helpers.process_endpoint("ShippingService.getOrderTotalShippingOption", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#shipping-retrieve-order-quantity-shipping-options"
  @spec retrieve_order_quantity_shipping_options(integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, any()}
  def retrieve_order_quantity_shipping_options(option_id, token, app \\ nil) do
    params = Helpers.build_params([option_id], token, app)
    Helpers.process_endpoint("ShippingService.getOrderQuantityShippingOption", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#shipping-retrieve-order-shipping-ranges"
  @spec retrieve_order_shipping_ranges(integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, any()}
  def retrieve_order_shipping_ranges(option_id, token, app \\ nil) do
    params = Helpers.build_params([option_id], token, app)
    Helpers.process_endpoint("ShippingService.getOrderTotalShippingRanges", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#shipping-retrieve-ups-shipping-option"
  @spec retrieve_ups_shipping_option(integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, any()}
  def retrieve_ups_shipping_option(option_id, token, app \\ nil) do
    params = Helpers.build_params([option_id], token, app)
    Helpers.process_endpoint("ShippingService.getUpsShippingOption", params, token, app)
  end
end
