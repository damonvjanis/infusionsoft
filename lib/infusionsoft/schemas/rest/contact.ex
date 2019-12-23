defmodule Infusionsoft.Schemas.REST.Contact do
  @moduledoc false

  # Functions to translate between common names and REST API names for Contact.

  alias Infusionsoft.Caches.ContactCustomFields
  alias Infusionsoft.Caches.Companies

  @common_names [
    "Anniversary",
    "Birthday",
    "Person Notes",
    "Date Created",
    "First Name",
    "Tags",
    "Id",
    "Job Title",
    "Last Name",
    "Last Updated",
    "Middle Name",
    "Nickname",
    "Spouse Name",
    "Suffix",
    "Time Zone",
    "Title",
    "Website",
    "Lead Source Id"
  ]

  @common_address [
    "billing address city",
    "billing address country",
    "billing address postal code",
    "billing address state",
    "billing address street 1",
    "billing address street 2",
    "billing address zip four",
    "other address city",
    "other address country",
    "other address postal code",
    "other address state",
    "other address street 1",
    "other address street 2",
    "other address zip four",
    "shipping address city",
    "shipping address country",
    "shipping address postal code",
    "shipping address state",
    "shipping address street 1",
    "shipping address street 2",
    "shipping address zip four"
  ]

  @common_email [
    "email",
    "email 2",
    "email 3"
  ]

  @common_fax [
    "fax 1",
    "fax 1 type",
    "fax 2",
    "fax 2 type"
  ]

  @common_phone [
    "phone 1 ext",
    "phone 1 type",
    "phone 1",
    "phone 2 ext",
    "phone 2 type",
    "phone 2",
    "phone 3 ext",
    "phone 3 type",
    "phone 3",
    "phone 4 ext",
    "phone 4 type",
    "phone 4",
    "phone 5 ext",
    "phone 5 type",
    "phone 5"
  ]

  @common_social [
    "facebook",
    "twitter",
    "linkedin"
  ]

  @common_company [
    "company"
  ]

  @common_contact_type [
    "person type"
  ]

  @common_in_rest_objects @common_address ++
                            @common_email ++
                            @common_fax ++
                            @common_company ++
                            @common_phone ++
                            @common_social ++
                            @common_contact_type

  @rest_names [
    "anniversary",
    "birthday",
    "notes",
    "date_created",
    "given_name",
    "tag_ids",
    "id",
    "job_title",
    "family_name",
    "last_updated",
    "middle_name",
    "preferred_name",
    "spouse_name",
    "suffix",
    "time_zone",
    "prefix",
    "website",
    "lead_source_id"
  ]

  @rest_object_identifiers [
    "addresses",
    "company",
    "custom_fields",
    "email_addresses",
    "fax_numbers",
    "phone_numbers",
    "social_accounts"
  ]

  @accepted_rest @rest_names ++ @rest_object_identifiers

  @rest_unique [
    "email_status",
    "origin",
    "relationships",
    "source_type",
    "owner_id",
    "preferred_locale",
    "opt_in_reason",
    "email_opted_in"
  ]

  @common_names_downcase Enum.map(@common_names, &String.downcase/1)

  @all_common_downcase @common_in_rest_objects ++ @common_names_downcase

  @common_to_rest_downcase Enum.zip(@common_names_downcase, @rest_names) |> Enum.into(%{})

  @rest_to_common Enum.zip(@rest_names, @common_names) |> Enum.into(%{})

  @spec to_rest(map(), String.t()) :: {:ok, map()} | {:error, String.t()}
  def to_rest(data, token) do
    data
    |> Enum.into(%{}, fn {k, v} -> {String.downcase(k), v} end)
    |> Enum.group_by(&find_grouping/1)
    |> Enum.map(fn {group, values} -> group_to_rest(group, values, token) end)
    |> List.flatten()
    |> Map.new()
    |> case do
      %{:error => error} -> {:error, error}
      fields -> {:ok, fields}
    end
  end

  defp find_grouping({k, _v}) when k in @common_names_downcase, do: "regular"
  defp find_grouping({k, _v}) when k in @common_address, do: "addresses"
  defp find_grouping({k, _v}) when k in @common_phone, do: "phones"
  defp find_grouping({k, _v}) when k in @common_fax, do: "faxes"
  defp find_grouping({k, _v}) when k in @common_email, do: "emails"
  defp find_grouping({k, _v}) when k in @common_social, do: "social"
  defp find_grouping({k, _v}) when k in @common_company, do: "company"
  defp find_grouping({k, _v}) when k in @common_contact_type, do: "contact_type"
  defp find_grouping({k, _v}) when k not in @all_common_downcase, do: "custom"

  defp group_to_rest("regular", values, _token) do
    Enum.map(values, fn {k, v} -> {@common_to_rest_downcase[k], v} end)
  end

  defp group_to_rest("addresses", values, _token) do
    for {k, v} <- values do
      case String.split(k, " ") do
        ["billing" | [_ | label]] -> {"billing", {to_address_fields(Enum.join(label, " ")), v}}
        ["shipping" | [_ | label]] -> {"shipping", {to_address_fields(Enum.join(label, " ")), v}}
        ["other" | [_ | label]] -> {"other", {to_address_fields(Enum.join(label, " ")), v}}
      end
    end
    |> Enum.group_by(fn {type, _} -> type end, fn {_, value} -> value end)
    |> Enum.map(fn {type, v} -> v |> Map.new() |> Map.put("field", String.upcase(type)) end)
    |> Enum.map(fn
      group = %{"zip_code" => z, "zip_four" => f} -> Map.put(group, "postal_code", "#{z} - #{f}")
      group = %{"zip_code" => z} -> Map.put(group, "postal_code", z)
      group -> group
    end)
    |> create_two_element_tuple("addresses")
  end

  defp group_to_rest("phones", values, _token) do
    for {k, v} <- values do
      case String.split(k, " ") do
        [_, num, "type"] -> {num, {"type", v}}
        [_, num, "ext"] -> {num, {"extension", v}}
        [_, num] -> {num, {"number", v}}
      end
    end
    |> Enum.group_by(fn {num, _} -> num end, fn {_, value} -> value end)
    |> Enum.map(fn {num, v} -> v |> Map.new() |> Map.put("field", "PHONE" <> num) end)
    |> create_two_element_tuple("phone_numbers")
  end

  defp group_to_rest("faxes", values, _token) do
    for {k, v} <- values do
      case String.split(k, " ") do
        [_, num, "type"] -> {num, {"type", v}}
        [_, num] -> {num, {"number", v}}
      end
    end
    |> Enum.group_by(fn {num, _} -> num end, fn {_, value} -> value end)
    |> Enum.map(fn {num, v} -> v |> Map.new() |> Map.put("field", "FAX" <> num) end)
    |> create_two_element_tuple("fax_numbers")
  end

  defp group_to_rest("emails", values, _token) do
    for {k, v} <- values do
      case k do
        "email" -> %{"field" => "EMAIL1", "email" => v}
        "email2" -> %{"field" => "EMAIL2", "email" => v}
        "email3" -> %{"field" => "EMAIL3", "email" => v}
      end
    end
    |> create_two_element_tuple("email_addresses")
  end

  defp group_to_rest("social", values, _token) do
    values
    |> Enum.map(fn {k, v} -> %{"name" => v, "type" => social_caps(k)} end)
    |> create_two_element_tuple("social_accounts")
  end

  defp group_to_rest("company", [{"company", company_name}], token) do
    case Companies.lookup(company_name, token) do
      {:ok, %{"Id" => id}} -> {"company", %{"id" => id}}
      {:error, error} -> {:error, error}
    end
  end

  defp group_to_rest("contact_type", [{"person type", value}], _token) do
    {"contact_type", caps(value)}
  end

  defp group_to_rest("custom", values, token) do
    for {k, v} <- values do
      with {:ok, field} <- ContactCustomFields.lookup(k, token) do
        %{"id" => field["Id"], "content" => v}
      end
    end
    |> create_two_element_tuple("custom_fields")
  end

  defp group_to_rest(:error, values, _token) do
    values
    |> Enum.map(fn {k, _v} -> {:error, ~s|No contact custom field "#{k}" exists|} end)
    |> Enum.reverse()
  end

  defp to_address_fields("street 1"), do: "line1"
  defp to_address_fields("street 2"), do: "line2"
  defp to_address_fields("city"), do: "locality"
  defp to_address_fields("state"), do: "region"
  defp to_address_fields("postal code"), do: "zip_code"
  defp to_address_fields("zip four"), do: "zip_four"
  defp to_address_fields("country"), do: "country_code"

  defp caps(nil), do: nil
  defp caps(str), do: str |> String.split(" ") |> Enum.map(&String.capitalize/1) |> Enum.join(" ")

  defp social_caps("facebook"), do: "Facebook"
  defp social_caps("linkedin"), do: "LinkedIn"
  defp social_caps("twitter"), do: "Twitter"

  defp create_two_element_tuple(object_from_pipe, key), do: {key, object_from_pipe}

  @spec from_rest(map(), String.t()) :: {:ok, map()} | {:error, String.t()}
  def from_rest(rest_object, token) do
    for {k, v} <- rest_object, v not in ["", [], nil], k in @accepted_rest do
      field_from_rest(k, v, token)
    end
    |> List.flatten()
    |> Map.new()
    |> case do
      %{:error => error} -> {:error, error}
      fields -> {:ok, fields}
    end
  end

  defp field_from_rest("addresses", v, _), do: Enum.map(v, &from_addresses/1)
  defp field_from_rest("email_addresses", v, _), do: Enum.map(v, &from_emails/1)
  defp field_from_rest("fax_numbers", v, _), do: Enum.map(v, &from_fax_numbers/1)
  defp field_from_rest("phone_numbers", v, _), do: Enum.map(v, &from_phone_numbers/1)
  defp field_from_rest("custom_fields", v, token), do: Enum.map(v, &from_custom_fields(&1, token))
  defp field_from_rest("social_accounts", v, _), do: Enum.map(v, &{&1["type"], &1["name"]})
  defp field_from_rest("company", v, _), do: {"Company", v["company_name"]}
  defp field_from_rest(k, v, _) when k in @rest_names, do: {@rest_to_common[k], v}
  defp field_from_rest(k, _, _) when k in @rest_unique, do: {:error, "#{k} not implemented"}
  defp field_from_rest(k, _, _), do: {:error, "#{k} not recognized or implemented"}

  defp from_addresses(address = %{"field" => type}) do
    for {k, v} <- address, v not in ["", nil], k not in ["field", "postal_code"] do
      from_address_fields(String.capitalize(type), k, v)
    end
  end

  defp from_address_fields(type, "line1", v), do: {"#{type} Address Street 1", v}
  defp from_address_fields(type, "line2", v), do: {"#{type} Address Street 2", v}
  defp from_address_fields(type, "locality", v), do: {"#{type} Address City", v}
  defp from_address_fields(type, "region", v), do: {"#{type} Address State", v}
  defp from_address_fields(type, "zip_code", v), do: {"#{type} Address Postal Code", v}
  defp from_address_fields(type, "zip_four", v), do: {"#{type} Address Zip Four", v}
  defp from_address_fields(type, "country_code", v), do: {"#{type} Address Country", v}

  defp from_emails(%{"field" => "EMAIL1", "email" => email}), do: {"Email", email}
  defp from_emails(%{"field" => "EMAIL2", "email" => email}), do: {"Email 2", email}
  defp from_emails(%{"field" => "EMAIL3", "email" => email}), do: {"Email 3", email}

  defp from_fax_numbers(%{"number" => number, "field" => field, "type" => type}) do
    count = String.last(field)
    [{"Fax #{count}", number}, {"Fax #{count} Type", type}]
  end

  defp from_phone_numbers(phone = %{"field" => "PHONE" <> n}) do
    %{"number" => number, "type" => type, "extension" => extension} = phone

    if extension not in [nil, ""] do
      [{"Phone #{n}", number}, {"Phone #{n} Ext", extension}, {"Phone #{n} Type", type}]
    else
      [{"Phone #{n}", number}, {"Phone #{n} Type", type}]
    end
  end

  defp from_custom_fields(%{"id" => id, "content" => content}, token) do
    with {:ok, field} <- ContactCustomFields.lookup(id, token) do
      {field["Label"], content}
    end
  end
end
