defmodule Infusionsoft.Schemas.Contacts do
  @moduledoc """
  Contains the basic lists of Common, REST, and XML names for Contacts.

  Also contains functions to create mappings between name lists and for extracting the name lists.
  """

  # TODO find the common names and replace this list. All but first and last name are XML names.
  @common_names [
    "AccountId",
    "Address1Type",
    "Address2Street1",
    "Address2Street2",
    "Address2Type",
    "Address3Street1",
    "Address3Street2",
    "Address3Type",
    "Anniversary",
    "AssistantName",
    "AssistantPhone",
    "BillingInformation",
    "Birthday",
    "City",
    "City2",
    "City3",
    "Company",
    "CompanyID",
    "ContactNotes",
    "ContactType",
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
    "First Name",
    "Groups",
    "Id",
    "JobTitle",
    "Language",
    "Last Name",
    "LastUpdated",
    "LastUpdatedBy",
    "LeadSourceId",
    "Leadsource",
    "MiddleName",
    "Nickname",
    "OwnerID",
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
    "ReferralCode",
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
    "Validated",
    "Website",
    "ZipFour1",
    "ZipFour2",
    "ZipFour3"
  ]

  # TODO find the REST names and replace this list. All but given and family name are XML names.
  @rest_names [
    "AccountId",
    "Address1Type",
    "Address2Street1",
    "Address2Street2",
    "Address2Type",
    "Address3Street1",
    "Address3Street2",
    "Address3Type",
    "Anniversary",
    "AssistantName",
    "AssistantPhone",
    "BillingInformation",
    "Birthday",
    "City",
    "City2",
    "City3",
    "Company",
    "CompanyID",
    "ContactNotes",
    "ContactType",
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
    "given_name",
    "Groups",
    "Id",
    "JobTitle",
    "Language",
    "family_name",
    "LastUpdated",
    "LastUpdatedBy",
    "LeadSourceId",
    "Leadsource",
    "MiddleName",
    "Nickname",
    "OwnerID",
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
    "ReferralCode",
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
    "Validated",
    "Website",
    "ZipFour1",
    "ZipFour2",
    "ZipFour3"
  ]

  @xml_names [
    "AccountId",
    "Address1Type",
    "Address2Street1",
    "Address2Street2",
    "Address2Type",
    "Address3Street1",
    "Address3Street2",
    "Address3Type",
    "Anniversary",
    "AssistantName",
    "AssistantPhone",
    "BillingInformation",
    "Birthday",
    "City",
    "City2",
    "City3",
    "Company",
    "CompanyID",
    "ContactNotes",
    "ContactType",
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
    "LeadSourceId",
    "Leadsource",
    "MiddleName",
    "Nickname",
    "OwnerID",
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
    "ReferralCode",
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
    "Validated",
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
