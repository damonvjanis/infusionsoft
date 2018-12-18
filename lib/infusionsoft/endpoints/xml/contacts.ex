defmodule Infusionsoft.Endpoints.XML.Contacts do
  @moduledoc """
  Provides the endpoints to Infusionsoft's XML API for Contacts.

  A few endpoints that are available in the API documentation have not been implemented here,
  but the function names have been included in comments.
  """
  alias Infusionsoft.Endpoints.XML

  def create(data, token) do
    params = ["", data]
    XML.process_endpoint("ContactService.add", params, token)
  end

  def create_with_dupe_check(data, token, check_type) do
    if check_type not in ["Email", "EmailAndName", "EmailAndNameAndCompany"] do
      {:error, "The check_type needs to be one of Email, EmailAndName, or EmailAndNameAndCompany"}
    else
      params = ["", data, check_type]
      XML.process_endpoint("ContactService.addWithDupCheck", params, token)
    end
  end

  def retrieve(id, fields, token) do
    params = ["", id, fields]
    XML.process_endpoint("ContactService.load", params, token)
  end

  def update(id, data, token) do
    params = ["", id, data]
    XML.process_endpoint("ContactService.update", params, token)
  end

  def merge(id, id_duplicate, token) do
    params = ["", id, id_duplicate]
    XML.process_endpoint("ContactService.merge", params, token)
  end

  def search_by_email(email, fields, token) do
    params = ["", email, fields]
    XML.process_endpoint("ContactService.findByEmail", params, token)
  end

  def add_tag(contact_id, tag_id, token) do
    params = ["", contact_id, tag_id]
    XML.process_endpoint("ContactService.addToGroup", params, token)
  end

  def remove_tag(contact_id, tag_id, token) do
    params = ["", contact_id, tag_id]
    XML.process_endpoint("ContactService.removeFromGroup", params, token)
  end

  # add_to_follow_up_sequence
  # next_follow_up_sequence_step
  # execute_follow_up_step
  # pause_follow_up_sequence
  # resume_follow_up_sequence
  # remove_from_follow_up_sequence

  def link(contact_id_1, contact_id_2, link_type_id, token) do
    params = ["", contact_id_1, contact_id_2, link_type_id]
    XML.process_endpoint("ContactService.linkContacts", params, token)
  end

  def unlink(contact_id_1, contact_id_2, link_type_id, token) do
    params = ["", contact_id_1, contact_id_2, link_type_id]
    XML.process_endpoint("ContactService.unlinkContacts", params, token)
  end

  def list_linked_contacts(id, token) do
    params = ["", id]
    XML.process_endpoint("ContactService.listLinkedContacts", params, token)
  end

  # run_action_set
end
