defmodule Infusionsoft do
  @moduledoc """
  Documentation for Infusionsoft.

  One important thing to note is that if you have multiple custom fields with the same name,
  even if the capitalization is different, things may not work the way you expect.

  The same is true for tags. If you need to support tags with the same name in
  different categories, you can provide the category name as an option in all tag calls.
  However, if you have multiple tags in the same category with the same name, things
  may not work the way you expect.
  """

  alias Infusionsoft.Endpoints.XML.Contacts, as: ContactsXML
  alias Infusionsoft.Endpoints.XML.Funnel, as: FunnelXML

  def create_contact(data, token) do
    ContactsXML.create(data, token)
  end

  def create_with_dupe_check(data, token, check_type) do
    ContactsXML.create_with_dupe_check(data, token, check_type)
  end

  def retrieve(id, fields, token) do
    ContactsXML.retrieve(id, fields, token)
  end

  def update(id, data, token) do
    ContactsXML.update(id, data, token)
  end

  def merge(id, id_duplicate, token) do
    ContactsXML.merge(id, id_duplicate, token)
  end

  def search_by_email(email, fields, token) do
    ContactsXML.search_by_email(email, fields, token)
  end

  def add_tag(contact_id, tag_id, token) do
    ContactsXML.add_tag(contact_id, tag_id, token)
  end

  def remove_tag(contact_id, tag_id, token) do
    ContactsXML.remove_tag(contact_id, tag_id, token)
  end

  @spec link(any(), any(), any(), any()) ::
          {:error, any()}
          | {:ok,
             false
             | nil
             | true
             | binary()
             | [false | nil | true | binary() | number()]
             | number()
             | map()}
  def link(contact_id_1, contact_id_2, link_type_id, token) do
    ContactsXML.link(contact_id_1, contact_id_2, link_type_id, token)
  end

  def unlink(contact_id_1, contact_id_2, link_type_id, token) do
    ContactsXML.unlink(contact_id_1, contact_id_2, link_type_id, token)
  end

  def list_linked_contacts(id, token) do
    ContactsXML.list_linked_contacts(id, token)
  end

  def achieve_goal(contact_id, integration_name, call_name, token) do
    FunnelXML.achieve_goal(contact_id, integration_name, call_name, token)
  end
end
