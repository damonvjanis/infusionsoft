defmodule Infusionsoft.Endpoints.XML.Email do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Email actions.
  """
  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#email-opt-in-an-email-address"
  @spec opt_in_an_email_address(String.t(), String.t(), String.t(), nil | String.t()) ::
          {:ok, boolean()} | {:error, String.t()}
  def opt_in_an_email_address(email, opt_in_reason, token, app \\ nil) do
    params = Helpers.build_params([email, opt_in_reason], token, app)
    Helpers.process_endpoint("APIEmailService.optIn", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#email-opt-out-an-email-address"
  @spec opt_out_an_email_address(String.t(), String.t(), String.t(), nil | String.t()) ::
          {:ok, boolean()} | {:error, String.t()}
  def opt_out_an_email_address(email, opt_out_reason, token, app \\ nil) do
    params = Helpers.build_params([email, opt_out_reason], token, app)
    Helpers.process_endpoint("APIEmailService.optOut", params, token, app)
  end

  @doc """
  https://developer.infusionsoft.com/docs/xml-rpc/#email-retrieve-an-email-s-opt-in-status

  Returns an integer value of 0 for opt out / non-marketable / soft bounce / hard bounce,
  1 for single opt-in, or 2 for double opt-in.
  """
  @spec retrieve_opt_in_status(String.t(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, String.t()}
  def retrieve_opt_in_status(email, token, app \\ nil) do
    params = Helpers.build_params([email], token, app)
    Helpers.process_endpoint("APIEmailService.getOptStatus", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#email-create-an-email-template"
  @spec create_email_template(
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, String.t()}
  def create_email_template(
        template_name,
        categories,
        from_address,
        to_address,
        cc_address,
        bcc_address,
        subject,
        text_body,
        html_body,
        content_type,
        merge_context,
        token,
        app \\ nil
      ) do
    params =
      Helpers.build_params(
        [
          template_name,
          categories,
          from_address,
          to_address,
          cc_address,
          bcc_address,
          subject,
          text_body,
          html_body,
          content_type,
          merge_context
        ],
        token,
        app
      )

    if content_type in ["HTML", "Text", "Multipart"] do
      if merge_context in ["Contact", "Opportunity", "Invoice", "CreditCard"] do
        Helpers.process_endpoint("APIEmailService.addEmailTemplate", params, token, app)
      else
        {:error, "merge_context must be one of Contact, Opportunity, Invoice, or CreditCard"}
      end
    else
      {:error, "content_type must be one of HTML, Text, or Multipart"}
    end
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#email-retrieve-an-email-template"
  @spec retrieve_email_template(integer(), String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, String.t()}
  def retrieve_email_template(template_id, token, app \\ nil) do
    params = Helpers.build_params([template_id], token, app)
    Helpers.process_endpoint("APIEmailService.getEmailTemplate", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#email-update-an-email-template"
  @spec update_email_template(
          integer(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          nil | String.t()
        ) :: {:ok, integer()} | {:error, String.t()}
  def update_email_template(
        template_id,
        template_name,
        categories,
        from_address,
        to_address,
        cc_address,
        bcc_address,
        subject,
        text_body,
        html_body,
        content_type,
        merge_context,
        token,
        app \\ nil
      ) do
    params =
      Helpers.build_params(
        [
          template_id,
          template_name,
          categories,
          from_address,
          to_address,
          cc_address,
          bcc_address,
          subject,
          text_body,
          html_body,
          content_type,
          merge_context
        ],
        token,
        app
      )

    if content_type in ["HTML", "Text", "Multipart"] do
      if merge_context in ["Contact", "Opportunity", "Invoice", "CreditCard"] do
        Helpers.process_endpoint("APIEmailService.updateEmailTemplate", params, token, app)
      else
        {:error, "merge_context must be one of Contact, Opportunity, Invoice, or CreditCard"}
      end
    else
      {:error, "content_type must be one of HTML, Text, or Multipart"}
    end
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#email-send-an-email-from-a-template"
  @spec send_from_template([integer()], integer(), String.t(), nil | String.t()) ::
          {:ok, boolean()} | {:error, String.t()}
  def send_from_template(contact_list, template_id, token, app \\ nil) do
    params = Helpers.build_params([contact_list, template_id], token, app)
    Helpers.process_endpoint("APIEmailService.sendEmail", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#email-send-an-email"
  @spec send_an_email(
          [integer()],
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          nil | String.t()
        ) :: {:ok, boolean()} | {:error, String.t()}
  def send_an_email(
        contact_list,
        from_address,
        to_address,
        cc_addresses,
        bcc_addresses,
        content_type,
        subject,
        html_body,
        text_body,
        token,
        app \\ nil
      ) do
    params =
      Helpers.build_params(
        [
          contact_list,
          from_address,
          to_address,
          cc_addresses,
          bcc_addresses,
          content_type,
          subject,
          html_body,
          text_body
        ],
        token,
        app
      )

    if content_type in ["HTML", "Text", "Multipart"] do
      Helpers.process_endpoint("APIEmailService.sendEmail", params, token, app)
    else
      {:error, "content_type must be one of HTML, Text, or Multipart"}
    end
  end

  # Retrieve Merge Fields (no xml endpoint)
  # https://developer.infusionsoft.com/docs/xml-rpc/#email-retrieve-available-merge-fields

  # Log sent email (needs testing to determine actual type of date for received and sent dates)
  # https://developer.infusionsoft.com/docs/xml-rpc/#email-manually-log-a-sent-email
end
