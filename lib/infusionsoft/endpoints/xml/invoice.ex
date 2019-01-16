defmodule Infusionsoft.Endpoints.XML.Invoice do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Invoice.
  """

  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-create-an-invoice"
  @spec create_an_invoice(
          integer(),
          String.t(),
          %NaiveDateTime{},
          integer(),
          integer(),
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, any()}
  def create_an_invoice(
        contact_id,
        name,
        order_date,
        lead_affiliate_id,
        sale_affiliate_id,
        token,
        app \\ nil
      ) do
    order_date = XMLRPC.DateTime.new(NaiveDateTime.to_erl(order_date))

    params =
      Helpers.build_params(
        [contact_id, name, order_date, lead_affiliate_id, sale_affiliate_id],
        token,
        app
      )

    Helpers.process_endpoint("InvoiceService.createBlankOrder", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-pay-an-invoice"
  @spec pay_an_invoice(
          integer(),
          String.t(),
          integer(),
          integer(),
          boolean(),
          String.t(),
          nil | String.t()
        ) :: {:ok, map()} | {:error, any()}
  def pay_an_invoice(
        invoice_id,
        notes,
        credit_card_id,
        merchant_account_id,
        bypass_commissions,
        token,
        app \\ nil
      ) do
    params =
      Helpers.build_params(
        [invoice_id, notes, credit_card_id, merchant_account_id, bypass_commissions],
        token,
        app
      )

    Helpers.process_endpoint("InvoiceService.chargeInvoice", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-retrieve-invoice-payments"
  @spec retrieve_invoice_payments(integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, any()}
  def retrieve_invoice_payments(invoice_id, token, app \\ nil) do
    params = Helpers.build_params([invoice_id], token, app)
    Helpers.process_endpoint("InvoiceService.getPayments", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-retrieve-invoice-amount-due"
  @spec retrieve_invoice_amount_due(integer(), String.t(), nil | String.t()) ::
          {:ok, float()} | {:error, any()}
  def retrieve_invoice_amount_due(invoice_id, token, app \\ nil) do
    params = Helpers.build_params([invoice_id], token, app)
    Helpers.process_endpoint("InvoiceService.calculateAmountOwed", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-add-an-item-to-an-invoice"
  @spec add_an_item_to_an_invoice(
          integer(),
          integer(),
          integer(),
          float(),
          integer(),
          String.t(),
          String.t(),
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, any()}
  def add_an_item_to_an_invoice(
        invoice_id,
        product_id,
        type,
        price,
        quantity,
        description,
        notes,
        token,
        app \\ nil
      ) do
    if type < 1 || type > 14 do
      {:error, "Type must be an integer between 1 and 14"}
    else
      params =
        Helpers.build_params(
          [invoice_id, product_id, type, price, quantity, description, notes],
          token,
          app
        )

      Helpers.process_endpoint("InvoiceService.addOrderItem", params, token, app)
    end
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-add-a-payment-to-an-invoice"
  @spec add_a_payment_to_an_invoice(
          integer(),
          float(),
          %NaiveDateTime{},
          String.t(),
          String.t(),
          boolean(),
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, any()}
  def add_a_payment_to_an_invoice(
        invoice_id,
        amount,
        date,
        payment_type,
        description,
        bypass_commissions,
        token,
        app \\ nil
      ) do
    date = XMLRPC.DateTime.new(NaiveDateTime.to_erl(date))

    params =
      Helpers.build_params(
        [invoice_id, amount, date, payment_type, description, bypass_commissions],
        token,
        app
      )

    Helpers.process_endpoint("InvoiceService.addManualPayment", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-add-a-commission-to-an-invoice"
  @spec add_a_commission_to_an_invoice(
          integer(),
          integer(),
          integer(),
          integer(),
          float(),
          integer(),
          String.t(),
          %NaiveDateTime{},
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, any()}
  def add_a_commission_to_an_invoice(
        invoice_id,
        affiliate_id,
        product_id,
        percent,
        amount,
        payout_type,
        description,
        date,
        token,
        app \\ nil
      ) do
    date = XMLRPC.DateTime.new(NaiveDateTime.to_erl(date))

    params =
      Helpers.build_params(
        [invoice_id, affiliate_id, product_id, percent, amount, payout_type, description, date],
        token,
        app
      )

    if payout_type not in [4, 5] do
      {:error, "Payout Type must be either 4 or 5"}
    else
      Helpers.process_endpoint("InvoiceService.addOrderCommissionOverride", params, token, app)
    end
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-calculate-invoice-tax"
  @spec calculate_invoice_tax(integer(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, any()}
  def calculate_invoice_tax(invoice_id, token, app \\ nil) do
    params = Helpers.build_params([invoice_id], token, app)
    Helpers.process_endpoint("InvoiceService.recalculateTax", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-delete-an-invoice"
  @spec delete_an_invoice(integer(), String.t(), nil | String.t()) ::
          {:ok, boolean()} | {:error, any()}
  def delete_an_invoice(invoice_id, token, app \\ nil) do
    params = Helpers.build_params([invoice_id], token, app)
    Helpers.process_endpoint("InvoiceService.deleteInvoice", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-create-a-contact-subscription"
  @spec create_a_contact_subscription(
          integer(),
          boolean(),
          integer(),
          integer(),
          float(),
          boolean(),
          integer(),
          integer(),
          integer(),
          integer(),
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, any()}
  def create_a_contact_subscription(
        contact_id,
        allow_duplicate,
        subscription_id,
        quantity,
        price,
        taxable,
        merchant_account_id,
        credit_card_id,
        affiliate_id,
        trial_period,
        token,
        app \\ nil
      ) do
    params =
      Helpers.build_params(
        [
          contact_id,
          allow_duplicate,
          subscription_id,
          quantity,
          price,
          taxable,
          merchant_account_id,
          credit_card_id,
          affiliate_id,
          trial_period
        ],
        token,
        app
      )

    Helpers.process_endpoint("InvoiceService.addRecurringOrder", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-create-a-subscription-invoice"
  @spec create_a_subscription_invoice(integer(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, any()}
  def create_a_subscription_invoice(subscription_id, token, app \\ nil) do
    params = Helpers.build_params([subscription_id], token, app)
    Helpers.process_endpoint("InvoiceService.createInvoiceForRecurring", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-update-subscription-billing-date"
  @spec update_subscription_billing_date(
          integer(),
          %NaiveDateTime{},
          String.t(),
          nil | String.t()
        ) :: {:ok, boolean()} | {:error, any()}
  def update_subscription_billing_date(subscription_id, next_bill_date, token, app \\ nil) do
    params = Helpers.build_params([subscription_id, next_bill_date], token, app)
    Helpers.process_endpoint("InvoiceService.updateJobRecurringNextBillDate", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-delete-a-subscription"
  @spec delete_a_subscription(integer(), String.t(), nil | String.t()) ::
          {:ok, boolean()} | {:error, any()}
  def delete_a_subscription(subscription_id, token, app \\ nil) do
    params = Helpers.build_params([subscription_id], token, app)
    Helpers.process_endpoint("InvoiceService.deleteSubscription", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-validate-a-new-credit-card"
  @spec validate_a_new_credit_card(
          String.t(),
          integer(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          nil | String.t()
        ) :: {:ok, map()} | {:error, any()}
  def validate_a_new_credit_card(
        card_type,
        contact_id,
        card_number,
        expiration_month,
        expiration_year,
        security_code,
        token,
        app \\ nil
      ) do
    params =
      Helpers.build_params(
        [card_type, contact_id, card_number, expiration_month, expiration_year, security_code],
        token,
        app
      )

    Helpers.process_endpoint("InvoiceService.validateCreditCard", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-validate-an-existing-credit-card"
  @spec validate_an_existing_credit_card(integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, any()}
  def validate_an_existing_credit_card(card_id, token, app \\ nil) do
    params = Helpers.build_params([card_id], token, app)
    Helpers.process_endpoint("InvoiceService.validateCreditCard", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-retrieve-credit-card"
  @spec retrieve_credit_card(integer(), String.t(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, any()}
  def retrieve_credit_card(contact_id, last_four, token, app \\ nil) do
    params = Helpers.build_params([contact_id, last_four], token, app)
    Helpers.process_endpoint("InvoiceService.locateExistingCard", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-retrieve-available-payment-options"
  @spec retrieve_available_payment_options(String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, any()}
  def retrieve_available_payment_options(token, app \\ nil) do
    params = Helpers.build_params(nil, token, app)
    Helpers.process_endpoint("InvoiceService.getAllPaymentOptions", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#invoice-create-a-custom-recurring-payment"
  @spec create_custom_recurring_payment(
          integer(),
          boolean(),
          integer(),
          integer(),
          integer(),
          integer(),
          float(),
          %NaiveDateTime{},
          %NaiveDateTime{},
          integer(),
          integer(),
          String.t(),
          nil | String.t()
        ) :: {:ok, boolean()} | {:error, any()}
  def create_custom_recurring_payment(
        invoice_id,
        auto_charge,
        credit_card_id,
        merchant_account_id,
        days_until_retry,
        max_retry,
        initial_payment_amount,
        initial_payment_date,
        plan_start_date,
        number_of_payments,
        days_between_payments,
        token,
        app \\ nil
      ) do
    params =
      Helpers.build_params(
        [
          invoice_id,
          auto_charge,
          credit_card_id,
          merchant_account_id,
          days_until_retry,
          max_retry,
          initial_payment_amount,
          initial_payment_date,
          plan_start_date,
          number_of_payments,
          days_between_payments
        ],
        token,
        app
      )

    Helpers.process_endpoint("InvoiceService.addPaymentPlan", params, token, app)
  end
end
