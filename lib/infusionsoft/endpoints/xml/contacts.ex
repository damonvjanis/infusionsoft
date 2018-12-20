defmodule Infusionsoft.Endpoints.XML.Contacts do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for Contacts.

  A few endpoints that are available in the API documentation have not been implemented,
  but the function names have been included in comments.

  This module is included in the documentation in case you want to bypass the conveniencies
  of working with display names and just interact with the raw XML API.
  """

  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-create-a-contact"
  @spec create(map(), String.t()) :: {:ok, integer()} | {:error, String.t()}
  def create(data, token) do
    params = ["", data]
    Helpers.process_endpoint("ContactService.add", params, token)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-create-a-contact-and-check-for-duplicates"
  @spec create_with_dupe_check(map(), String.t(), atom()) ::
          {:ok, integer()} | {:error, String.t()}
  def create_with_dupe_check(data, token, check_type) do
    if check_type not in ["Email", "EmailAndName", "EmailAndNameAndCompany"] do
      {:error, "The check_type needs to be one of Email, EmailAndName, or EmailAndNameAndCompany"}
    else
      params = ["", data, check_type]
      Helpers.process_endpoint("ContactService.addWithDupCheck", params, token)
    end
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-retrieve-a-contact"
  @spec retrieve(integer(), [String.t()], String.t()) :: {:ok, map()} | {:error, String.t()}
  def retrieve(id, fields, token) do
    params = ["", id, fields]
    Helpers.process_endpoint("ContactService.load", params, token)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-update-a-contact"
  @spec update(integer(), map(), String.t()) :: {:ok, integer()} | {:error, String.t()}
  def update(id, data, token) do
    params = ["", id, data]
    Helpers.process_endpoint("ContactService.update", params, token)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-merge-two-contacts"
  @spec merge(integer(), integer(), String.t()) :: {:ok, integer()} | {:error, String.t()}
  def merge(id, id_duplicate, token) do
    params = ["", id, id_duplicate]
    Helpers.process_endpoint("ContactService.merge", params, token)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-search-for-a-contact-by-an-email-address"
  @spec search_by_email(String.t(), list(), String.t()) :: {:ok, [map()]} | {:error, String.t()}
  def search_by_email(email, fields, token) do
    params = ["", email, fields]
    Helpers.process_endpoint("ContactService.findByEmail", params, token)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-add-a-tag-to-a-contact"
  @spec add_tag(integer(), integer(), String.t()) :: {:ok, true | false} | {:error, String.t()}
  def add_tag(contact_id, tag_id, token) do
    params = ["", contact_id, tag_id]
    Helpers.process_endpoint("ContactService.addToGroup", params, token)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-remove-a-tag-from-a-contact"
  @spec remove_tag(integer(), integer(), String.t()) :: {:ok, true | false} | {:error, String.t()}
  def remove_tag(contact_id, tag_id, token) do
    params = ["", contact_id, tag_id]
    Helpers.process_endpoint("ContactService.removeFromGroup", params, token)
  end

  # add_to_follow_up_sequence
  # next_follow_up_sequence_step
  # execute_follow_up_step
  # pause_follow_up_sequence
  # resume_follow_up_sequence
  # remove_from_follow_up_sequence

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-link-contacts"
  @spec link(integer(), integer(), integer(), String.t()) ::
          {:ok, true | false} | {:error, String.t()}
  def link(contact_id_1, contact_id_2, link_type_id, token) do
    params = ["", contact_id_1, contact_id_2, link_type_id]
    Helpers.process_endpoint("ContactService.linkContacts", params, token)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-unlink-contacts"
  @spec unlink(integer(), integer(), integer(), String.t()) ::
          {:ok, true | false} | {:error, String.t()}
  def unlink(contact_id_1, contact_id_2, link_type_id, token) do
    params = ["", contact_id_1, contact_id_2, link_type_id]
    Helpers.process_endpoint("ContactService.unlinkContacts", params, token)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#contact-list-linked-contacts"
  @spec list_linked_contacts(integer(), String.t()) :: {:ok, list()} | {:error, String.t()}
  def list_linked_contacts(id, token) do
    params = ["", id]
    Helpers.process_endpoint("ContactService.listLinkedContacts", params, token)
  end

  # run_action_set
end
