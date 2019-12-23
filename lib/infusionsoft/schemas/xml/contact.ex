defmodule Infusionsoft.Schemas.XML.Contact do
  @moduledoc false

  # Functions to translate between common names and XML api names for Contact.

  alias Infusionsoft.Caches.ContactCustomFields

  @common_names [
    "Shipping Address Street 1",
    "Shipping Address Street 2",
    "Other Address Street 1",
    "Other Address Street 2",
    "Anniversary",
    "Birthday",
    "Billing Address City",
    "Shipping Address City",
    "Other Address City",
    "Person Notes",
    "Billing Address Country",
    "Shipping Address Country",
    "Other Address Country",
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
    "Last Name",
    "Last Updated",
    "Middle Name",
    "Nickname",
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
    "Website",
    "Billing Address Zip Four",
    "Shipping Address Zip Four",
    "Other Address Zip Four",
    "Person Type",
    "Lead Source Id",
    "Company"
  ]

  @xml_names [
    "Address2Street1",
    "Address2Street2",
    "Address3Street1",
    "Address3Street2",
    "Anniversary",
    "Birthday",
    "City",
    "City2",
    "City3",
    "ContactNotes",
    "Country",
    "Country2",
    "Country3",
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
    "LastName",
    "LastUpdated",
    "MiddleName",
    "Nickname",
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
    "Website",
    "ZipFour1",
    "ZipFour2",
    "ZipFour3",
    "ContactType",
    "LeadSourceId",
    "CompanyId"
  ]

  # @xml_unique [
  #   "Assistant Name",
  #   "Assistant Phone",
  #   "Created By",
  #   "Language",
  #   "Last Updated By",
  #   "Password",
  #   "Username",
  #   "Lead Source",
  #   "Company"
  # ]

  @common_names_downcase Enum.map(@common_names, &String.downcase/1)

  @common_to_xml_downcase Enum.zip(@common_names_downcase, @xml_names) |> Enum.into(%{})

  @xml_to_common Enum.zip(@xml_names, @common_names) |> Enum.into(%{})

  @doc "Takes a list of Common names and returns XML names or list of errors"
  @spec to([String.t()], String.t(), nil | String.t()) :: {:ok, list()} | {:error, String.t()}
  def to(names, token, app) when is_list(names) do
    results = Enum.map(names, &get_name(&1, @common_to_xml_downcase, token, app, downcase: true))

    if !Enum.any?(results, fn {status, _} -> status == :error end) do
      {:ok, Enum.map(results, fn {_, name} -> name end)}
    else
      {:error,
       results
       |> Enum.filter(fn {status, _} -> status == :error end)
       |> Enum.map(fn {_, message} -> message end)
       |> Enum.join(", ")}
    end
  end

  @doc "Takes a list of XML names and returns Common names or list of errors"
  @spec from([String.t()], String.t(), nil | String.t()) :: {:ok, list()} | {:error, String.t()}
  def from(names, token, app) when is_list(names) do
    results = Enum.map(names, &get_name(&1, @xml_to_common, token, app))

    if !Enum.any?(results, fn {status, _} -> status == :error end) do
      {:ok, Enum.map(results, fn {_, name} -> name end)}
    else
      {:error,
       results
       |> Enum.filter(fn {status, _} -> status == :error end)
       |> Enum.map(fn {_, message} -> message end)
       |> Enum.join(", ")}
    end
  end

  defp get_name(name, map, token, app, opts \\ []) do
    # If our map has downcase keys we need to transform before accessing the map.
    opts = Keyword.merge([downcase: false], opts)
    value = if(Keyword.get(opts, :downcase), do: map[String.downcase(name)], else: map[name])

    if value do
      {:ok, value}
    else
      if String.first(name) == "_" do
        get_custom_field_from(name, token, app)
      else
        get_custom_field_to(name, token, app)
      end
    end
  end

  defp get_custom_field_to(name, token, app) do
    with {:ok, field} <- ContactCustomFields.lookup(name, token, app) do
      {:ok, "_" <> field["Name"]}
    end
  end

  defp get_custom_field_from(name, token, app) do
    with {:ok, field} <- ContactCustomFields.lookup(name, token, app) do
      {:ok, field["Label"]}
    end
  end
end
