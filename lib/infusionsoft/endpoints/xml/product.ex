defmodule Infusionsoft.Endpoints.XML.Product do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Product.
  """

  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#product-retrieve-available-product-inventory"
  @spec retrieve_inventory(integer(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, any()}
  def retrieve_inventory(product_id, token, app \\ nil) do
    params = Helpers.build_params([product_id], token, app)
    Helpers.process_endpoint("ProductService.getInventory", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#product-increment-available-product-inventory"
  @spec increment_inventory(integer(), String.t(), nil | String.t()) ::
          {:ok, boolean()} | {:error, any()}
  def increment_inventory(product_id, token, app \\ nil) do
    params = Helpers.build_params([product_id], token, app)
    Helpers.process_endpoint("ProductService.incrementInventory", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#product-decrement-available-product-inventory"
  @spec decrement_inventory(integer(), String.t(), nil | String.t()) ::
          {:ok, boolean()} | {:error, any()}
  def decrement_inventory(product_id, token, app \\ nil) do
    params = Helpers.build_params([product_id], token, app)
    Helpers.process_endpoint("ProductService.decrementInventory", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#product-increase-a-product-s-available-inventory"
  @spec increase_inventory(integer(), integer(), String.t(), nil | String.t()) ::
          {:ok, boolean()} | {:error, any()}
  def increase_inventory(product_id, quantity, token, app \\ nil) do
    params = Helpers.build_params([product_id, quantity], token, app)
    Helpers.process_endpoint("ProductService.increaseInventory", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#product-decrease-a-product-s-available-inventory"
  @spec decrease_product_inventory(integer(), integer(), String.t(), nil | String.t()) ::
          {:ok, boolean()} | {:error, any()}
  def decrease_product_inventory(product_id, quantity, token, app \\ nil) do
    params = Helpers.build_params([product_id, quantity], token, app)
    Helpers.process_endpoint("ProductService.decreaseInventory", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#product-deactivate-a-credit-card"
  @spec deactivate_a_credit_card(integer(), String.t(), nil | String.t()) ::
          {:ok, boolean()} | {:error, any()}
  def deactivate_a_credit_card(card_id, token, app \\ nil) do
    params = Helpers.build_params([card_id], token, app)
    Helpers.process_endpoint("ProductService.deactivateCreditCard", params, token, app)
  end
end
