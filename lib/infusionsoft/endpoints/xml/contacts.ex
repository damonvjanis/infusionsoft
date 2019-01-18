defmodule Infusionsoft.Endpoints.XML.Contact do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Contact.

  A few endpoints that are available in the API documentation have not been implemented,
  but the function names have been included in comments.
  """

  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-create-a-contact"
  @spec create_a_contact(map(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, String.t()}
  def create_a_contact(data, token, app \\ nil) do
    params = Helpers.build_params([data], token, app)
    Helpers.process_endpoint("ContactService.add", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-create-a-contact-and-check-for-duplicates"
  @spec create_and_check_for_duplicate(map(), String.t(), atom(), nil | String.t()) ::
          {:ok, integer()} | {:error, String.t()}
  def create_and_check_for_duplicate(data, dupe_check_type, token, app \\ nil) do
    if dupe_check_type not in ["Email", "EmailAndName", "EmailAndNameAndCompany"] do
      {:error,
       "The dupe_check_type needs to be one of Email, EmailAndName, or EmailAndNameAndCompany"}
    else
      params = Helpers.build_params([data, dupe_check_type], token, app)
      Helpers.process_endpoint("ContactService.addWithDupCheck", params, token, app)
    end
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-retrieve-a-contact"
  @spec retrieve_a_contact(integer(), [String.t()], String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, String.t()}
  def retrieve_a_contact(contact_id, selected_fields, token, app \\ nil) do
    params = Helpers.build_params([contact_id, selected_fields], token, app)
    Helpers.process_endpoint("ContactService.load", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-update-a-contact"
  @spec update_a_contact(integer(), map(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, String.t()}
  def update_a_contact(contact_id, data, token, app \\ nil) do
    params = Helpers.build_params([contact_id, data], token, app)
    Helpers.process_endpoint("ContactService.update", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-merge-two-contacts"
  @spec merge_contacts(integer(), integer(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, String.t()}
  def merge_contacts(contact_id, duplicate_contact_id, token, app \\ nil) do
    params = Helpers.build_params([contact_id, duplicate_contact_id], token, app)
    Helpers.process_endpoint("ContactService.merge", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-search-for-a-contact-by-an-email-address"
  @spec search_by_email(String.t(), [String.t()], String.t(), nil | String.t()) ::
          {:ok, [map()]} | {:error, String.t()}
  def search_by_email(email, selected_fields, token, app \\ nil) do
    params = Helpers.build_params([email, selected_fields], token, app)
    Helpers.process_endpoint("ContactService.findByEmail", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-add-a-tag-to-a-contact"
  @spec add_tag(integer(), integer(), String.t(), nil | String.t()) ::
          {:ok, true | false} | {:error, String.t()}
  def add_tag(contact_id, tag_id, token, app \\ nil) do
    params = Helpers.build_params([contact_id, tag_id], token, app)
    Helpers.process_endpoint("ContactService.addToGroup", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-remove-a-tag-from-a-contact"
  @spec remove_tag(integer(), integer(), String.t(), nil | String.t()) ::
          {:ok, true | false} | {:error, String.t()}
  def remove_tag(contact_id, tag_id, token, app \\ nil) do
    params = Helpers.build_params([contact_id, tag_id], token, app)
    Helpers.process_endpoint("ContactService.removeFromGroup", params, token, app)
  end

  # add_to_follow_up_sequence
  # next_follow_up_sequence_step
  # execute_follow_up_step
  # pause_follow_up_sequence
  # resume_follow_up_sequence
  # remove_from_follow_up_sequence

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-link-contacts"
  @spec link_contacts(integer(), integer(), integer(), String.t(), nil | String.t()) ::
          {:ok, true | false} | {:error, String.t()}
  def link_contacts(contact_id_1, contact_id_2, link_type_id, token, app \\ nil) do
    params = Helpers.build_params([contact_id_1, contact_id_2, link_type_id], token, app)
    Helpers.process_endpoint("ContactService.linkContacts", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-unlink-contacts"
  @spec unlink_contacts(integer(), integer(), integer(), String.t(), nil | String.t()) ::
          {:ok, true | false} | {:error, String.t()}
  def unlink_contacts(contact_id_1, contact_id_2, link_type_id, token, app \\ nil) do
    params = Helpers.build_params([contact_id_1, contact_id_2, link_type_id], token, app)
    Helpers.process_endpoint("ContactService.unlinkContacts", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-list-linked-contacts"
  @spec list_linked_contacts(integer(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def list_linked_contacts(contact_id, token, app \\ nil) do
    params = Helpers.build_params([contact_id], token, app)
    Helpers.process_endpoint("ContactService.listLinkedContacts", params, token, app)
  end

  # run_action_set
end
