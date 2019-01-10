defmodule Infusionsoft.Endpoints.XML.Discounts do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Discounts.
  """

  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#discount-create-an-order-discount"
  @spec create_order_discount(
          String.t(),
          String.t(),
          :percent | :amount,
          :gross | :net,
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, String.t()}
  def create_order_discount(name, apply_to_commision, percent_or_amt, pay_type, token, app \\ nil) do
    percent_or_amt =
      case percent_or_amt do
        :percent -> 1
        :amount -> 0
        any -> {:error, "The value '#{any}' is not a valid argument"}
      end

    pay_type =
      case pay_type do
        :gross -> "gross"
        :net -> "net"
        any -> {:error, "The value '#{any}' is not a valid argument"}
      end

    params =
      Helpers.build_params([name, apply_to_commision, percent_or_amt, pay_type], token, app)

    cond do
      is_integer(percent_or_amt) and is_binary(pay_type) ->
        Helpers.process_endpoint("DiscountService.getOrderTotalDiscount", params, token, app)

      is_tuple(percent_or_amt) ->
        percent_or_amt

      is_tuple(pay_type) ->
        pay_type
    end
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#discount-retrieve-an-order-s-total-discount"
  @spec retrieve_order_discount(integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, String.t()}
  def retrieve_order_discount(id, token, app \\ nil) do
    params = Helpers.build_params([id], token, app)
    Helpers.process_endpoint("DiscountService.getOrderTotalDiscount", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#discount-create-a-free-trial-on-a-subscription"
  @spec create_subscription_trial(
          String.t(),
          String.t(),
          integer(),
          boolean(),
          integer(),
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, String.t()}
  def create_subscription_trial(name, description, days, hide_price, plan_id, token, app \\ nil) do
    params = Helpers.build_params([name, description, days, hide_price, plan_id], token, app)
    Helpers.process_endpoint("DiscountService.addFreeTrial", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#discount-create-a-shipping-discount"
  @spec create_shipping_discount(
          String.t(),
          String.t(),
          boolean(),
          :percent | :amount,
          float(),
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, String.t()}
  def create_shipping_discount(
        name,
        description,
        apply_to_commission,
        percent_or_amt,
        amt,
        token,
        app \\ nil
      ) do
    percent_or_amt =
      case percent_or_amt do
        :percent -> 1
        :amount -> 0
        any -> {:error, "The value '#{any}' is not a valid argument"}
      end

    params =
      Helpers.build_params(
        [name, description, apply_to_commission, percent_or_amt, amt],
        token,
        app
      )

    if is_integer(percent_or_amt) do
      Helpers.process_endpoint("DiscountService.addShippingTotalDiscount", params, token, app)
    else
      percent_or_amt
    end
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#discount-retrieve-a-shipping-discount"
  @spec retrieve_shipping_discount(integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, String.t()}
  def retrieve_shipping_discount(id, token, app \\ nil) do
    params = Helpers.build_params([id], token, app)
    Helpers.process_endpoint("DiscountService.getShippingTotalDiscount", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#discount-create-a-product-discount"
  @spec create_product_discount(
          String.t(),
          String.t(),
          boolean(),
          integer(),
          :percent | :amount,
          float(),
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, String.t()}
  def create_product_discount(
        name,
        description,
        apply_to_commission,
        product_id,
        percent_or_amt,
        amt,
        token,
        app \\ nil
      ) do
    percent_or_amt =
      case percent_or_amt do
        :percent -> 1
        :amount -> 0
        any -> {:error, "The value '#{any}' is not a valid argument"}
      end

    params =
      Helpers.build_params(
        [name, description, apply_to_commission, product_id, percent_or_amt, amt],
        token,
        app
      )

    if is_integer(percent_or_amt) do
      Helpers.process_endpoint("DiscountService.addProductTotalDiscount", params, token, app)
    else
      percent_or_amt
    end
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#discount-retrieve-a-product-total-discount"
  @spec retrieve_product_discount(integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, String.t()}
  def retrieve_product_discount(id, token, app \\ nil) do
    params = Helpers.build_params([id], token, app)
    Helpers.process_endpoint("DiscountService.getProductTotalDiscount", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#discount-create-a-category-discount"
  @spec create_category_discount(
          String.t(),
          String.t(),
          boolean(),
          float(),
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, String.t()}
  def create_category_discount(name, description, apply_to_commission, amt, token, app \\ nil) do
    params = Helpers.build_params([name, description, apply_to_commission, amt], token, app)
    Helpers.process_endpoint("DiscountService.addCategoryDiscount", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#discount-retrieve-a-category-discount"
  @spec retrieve_category_discount(integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, String.t()}
  def retrieve_category_discount(id, token, app \\ nil) do
    params = Helpers.build_params([id], token, app)
    Helpers.process_endpoint("DiscountService.getCategoryDiscount", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#discount-retrieve-a-category-discount-s-category-assignments"
  @spec retrieve_category_discount_assignments(integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, String.t()}
  def retrieve_category_discount_assignments(id, token, app \\ nil) do
    params = Helpers.build_params([id], token, app)

    Helpers.process_endpoint(
      "DiscountService.getCategoryAssignmentsForCategoryDiscount",
      params,
      token,
      app
    )
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#discount-assign-a-product-to-a-category-discount"
  @spec assign_product_to_category_discount(integer(), integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, String.t()}
  def assign_product_to_category_discount(id, category_id, token, app \\ nil) do
    params = Helpers.build_params([id, category_id], token, app)

    Helpers.process_endpoint(
      "DiscountService.addCategoryAssignmentToCategoryDiscount",
      params,
      token,
      app
    )
  end
end
