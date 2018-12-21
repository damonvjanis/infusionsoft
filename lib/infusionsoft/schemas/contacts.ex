defmodule Infusionsoft.Schemas.Contacts do
  @moduledoc """
  Contains the basic lists of Common, REST, and XML names for Contacts.

  Also contains functions to create mappings between name lists and for extracting the name lists.
  """

  @common_names [
    "Shipping Address Street 1",
    "Shipping Address Street 2",
    "Other Address Street 1",
    "Other Address Street 2",
    "Anniversary",
    "Assistant Name",
    "Assistant Phone",
    "Birthday",
    "Billing Address City",
    "Shipping Address City",
    "Other Address City",
    "Company",
    "Person Notes",
    "Billing Address Country",
    "Shipping Address Country",
    "Other Address Country",
    "Created By",
    "Date Created",
    "Email",
    "Email 2",
    "Email 3",
    "Fax 1",
    "Fax 1 Type",
    "Fax 2",
    "Fax 2 Type",
    "First Name",
    "Tags",
    "Id",
    "Job Title",
    "Language",
    "Last Name",
    "Last Updated",
    "Last Updated By",
    "Middle Name",
    "Nickname",
    "Password",
    "Phone 1",
    "Phone 1 Ext",
    "Phone 1 Type",
    "Phone 2",
    "Phone 2 Ext",
    "Phone 2 Type",
    "Phone 3",
    "Phone 3 Ext",
    "Phone 3 Type",
    "Phone 4",
    "Phone 4 Ext",
    "Phone 4 Type",
    "Phone 5",
    "Phone 5 Ext",
    "Phone 5 Type",
    "Billing Address Postal Code",
    "Shipping Address Postal Code",
    "Other Address Postal Code",
    "Spouse Name",
    "Billing Address State",
    "Shipping Address State",
    "Other Address State",
    "Billing Address Street 1",
    "Billing Address Street 2",
    "Suffix",
    "Time Zone",
    "Title",
    "Username",
    "Website",
    "Billing Address Zip Four",
    "Shipping Address Zip Four",
    "Other Address Zip Four"
  ]

  # TODO find the REST names and replace this list. Currently matches Common Names except first and last name.
  @rest_names [
    "Shipping Address Street 1",
    "Shipping Address Street 2",
    "Other Address Street 1",
    "Other Address Street 2",
    "Anniversary",
    "Assistant Name",
    "Assistant Phone",
    "Birthday",
    "Billing Address City",
    "Shipping Address City",
    "Other Address City",
    "Company",
    "Person Notes",
    "Billing Address Country",
    "Shipping Address Country",
    "Other Address Country",
    "Created By",
    "Date Created",
    "Email",
    "Email 2",
    "Email 3",
    "Fax 1",
    "Fax 1 Type",
    "Fax 2",
    "Fax 2 Type",
    "given_name",
    "Tags",
    "Id",
    "Job Title",
    "Language",
    "family_name",
    "Last Updated",
    "Last Updated By",
    "Middle Name",
    "Nickname",
    "Password",
    "Phone 1",
    "Phone 1 Ext",
    "Phone 1 Type",
    "Phone 2",
    "Phone 2 Ext",
    "Phone 2 Type",
    "Phone 3",
    "Phone 3 Ext",
    "Phone 3 Type",
    "Phone 4",
    "Phone 4 Ext",
    "Phone 4 Type",
    "Phone 5",
    "Phone 5 Ext",
    "Phone 5 Type",
    "Billing Address Postal Code",
    "Shipping Address Postal Code",
    "Other Address Postal Code",
    "Spouse Name",
    "Billing Address State",
    "Shipping Address State",
    "Other Address State",
    "Billing Address Street 1",
    "Billing Address Street 2",
    "Suffix",
    "Time Zone",
    "Title",
    "Username",
    "Website",
    "Billing Address Zip Four",
    "Shipping Address Zip Four",
    "Other Address Zip Four"
  ]

  @xml_names [
    "Address2Street1",
    "Address2Street2",
    "Address3Street1",
    "Address3Street2",
    "Anniversary",
    "AssistantName",
    "AssistantPhone",
    "Birthday",
    "City",
    "City2",
    "City3",
    "Company",
    "ContactNotes",
    "Country",
    "Country2",
    "Country3",
    "CreatedBy",
    "DateCreated",
    "Email",
    "EmailAddress2",
    "EmailAddress3",
    "Fax1",
    "Fax1Type",
    "Fax2",
    "Fax2Type",
    "FirstName",
    "Groups",
    "Id",
    "JobTitle",
    "Language",
    "LastName",
    "LastUpdated",
    "LastUpdatedBy",
    "MiddleName",
    "Nickname",
    "Password",
    "Phone1",
    "Phone1Ext",
    "Phone1Type",
    "Phone2",
    "Phone2Ext",
    "Phone2Type",
    "Phone3",
    "Phone3Ext",
    "Phone3Type",
    "Phone4",
    "Phone4Ext",
    "Phone4Type",
    "Phone5",
    "Phone5Ext",
    "Phone5Type",
    "PostalCode",
    "PostalCode2",
    "PostalCode3",
    "SpouseName",
    "State",
    "State2",
    "State3",
    "StreetAddress1",
    "StreetAddress2",
    "Suffix",
    "TimeZone",
    "Title",
    "Username",
    "Website",
    "ZipFour1",
    "ZipFour2",
    "ZipFour3"
  ]

  @common_names_downcase Enum.map(@common_names, &String.downcase/1)

  @common_to_rest Enum.zip(@common_names, @rest_names) |> Enum.into(%{})

  @common_to_rest_downcase Enum.zip(@common_names_downcase, @rest_names) |> Enum.into(%{})

  @rest_to_common Enum.zip(@rest_names, @common_names) |> Enum.into(%{})

  @common_to_xml Enum.zip(@common_names, @xml_names) |> Enum.into(%{})

  @common_to_xml_downcase Enum.zip(@common_names_downcase, @xml_names) |> Enum.into(%{})

  @xml_to_common Enum.zip(@xml_names, @common_names) |> Enum.into(%{})

  @doc "Returns a map with Common names as keys and their REST equivalents as values"
  @spec common_to_rest() :: map()
  def common_to_rest() do
    @common_to_rest
  end

  @doc "Returns a map with downcased Common names as keys and their REST equivalents as values"
  @spec common_to_rest_downcase() :: map()
  def common_to_rest_downcase() do
    @common_to_rest_downcase
  end

  @doc "Returns a map with REST names as keys and their Common equivalents as values"
  @spec rest_to_common() :: map()
  def rest_to_common() do
    @rest_to_common
  end

  @doc "Returns a map with Common names as keys and their XML equivalents as values"
  @spec common_to_xml() :: map()
  def common_to_xml() do
    @common_to_xml
  end

  @doc "Returns a map with downcased Common names as keys and their XML equivalents as values"
  @spec common_to_xml_downcase() :: map()
  def common_to_xml_downcase() do
    @common_to_xml_downcase
  end

  @doc "Returns a map with XML names as keys and their Common equivalents as values"
  @spec xml_to_common() :: map()
  def xml_to_common() do
    @xml_to_common
  end

  @doc "Returns the standard list of Common names for Contacts."
  @spec list_common_names() :: [String.t()]
  def list_common_names() do
    @common_names
  end

  @doc "Returns the standard list of REST names for Contacts."
  @spec list_rest_names() :: [String.t()]
  def list_rest_names() do
    @rest_names
  end

  @doc "Returns the standard list of XML names for Contacts."
  @spec list_xml_names() :: [String.t()]
  def list_xml_names() do
    @xml_names
  end
end
