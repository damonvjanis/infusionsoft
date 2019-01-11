defmodule Infusionsoft.Endpoints.XML.Order do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Order actions.
  """
  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#order-create-an-order"
  @spec create_order(
          integer(),
          integer(),
          integer(),
          [integer()],
          [integer()],
          boolean(),
          [String.t()],
          integer(),
          integer(),
          String.t(),
          nil | String.t()
        ) :: {:ok, map()} | {:error, String.t()}
  def create_order(
        contact_id,
        card_id,
        plan_id,
        product_ids,
        subscription_ids,
        process_specials,
        promo_codes,
        lead_affiliate_id,
        sale_affiliate_id,
        token,
        app \\ nil
      ) do
    params =
      Helpers.build_params(
        [
          contact_id,
          card_id,
          plan_id,
          product_ids,
          subscription_ids,
          process_specials,
          promo_codes,
          lead_affiliate_id,
          sale_affiliate_id
        ],
        token,
        app
      )

    Helpers.process_endpoint("OrderService.placeOrder", params, token, app)
  end
end
