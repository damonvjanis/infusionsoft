defmodule Infusionsoft.Schemas.REST.ContactTest do
  use ExUnit.Case, async: true
  alias Infusionsoft.Schemas.REST.Contact

  describe "from_ functions" do
    # 2/22/19 https://developer.infusionsoft.com/docs/rest/#!/Contact/getContactUsingGET
    test "company" do
      contact = %{"company" => %{"company_name" => "string", "id" => 0}}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Company" => "string"}}
    end

    test "notes" do
      contact = %{"notes" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Person Notes" => "string"}}
    end

    test "job_title" do
      contact = %{"job_title" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Job Title" => "string"}}
    end

    test "source_type" do
      contact = %{"source_type" => "WEBFORM"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{}}
    end

    test "email_addresses" do
      contact = %{"email_addresses" => [%{"email" => "string", "field" => "EMAIL1"}]}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Email" => "string"}}
    end

    test "given_name" do
      contact = %{"given_name" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"First Name" => "string"}}
    end

    test "owner_id" do
      contact = %{"owner_id" => 0}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{}}
    end

    test "tag_ids" do
      contact = %{"tag_ids" => [0]}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Tags" => [0]}}
    end

    test "preferred_name" do
      contact = %{"preferred_name" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Nickname" => "string"}}
    end

    test "id" do
      contact = %{"id" => 0}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Id" => 0}}
    end

    test "date_created" do
      contact = %{"date_created" => "2019-02-23T06:29:40.855Z"}

      assert Contact.from_rest(contact, "unused_token") ==
               {:ok, %{"Date Created" => "2019-02-23T06:29:40.855Z"}}
    end

    test "relationships" do
      contact = %{
        "relationships" => [%{"id" => 0, "linked_contact_id" => 0, "relationship_type_id" => 0}]
      }

      assert Contact.from_rest(contact, "unused_token") == {:ok, %{}}
    end

    test "middle_name" do
      contact = %{"middle_name" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Middle Name" => "string"}}
    end

    test "fax_numbers" do
      contact = %{
        "fax_numbers" => [%{"field" => "FAX1", "number" => "number", "type" => "type"}]
      }

      assert Contact.from_rest(contact, "unused_token") ==
               {:ok, %{"Fax 1" => "number", "Fax 1 Type" => "type"}}
    end

    test "social_accounts" do
      contact = %{"social_accounts" => [%{"name" => "string", "type" => "Facebook"}]}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Facebook" => "string"}}
    end

    test "email_status" do
      contact = %{"email_status" => "UnengagedMarketable"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{}}
    end

    test "family_name" do
      contact = %{"family_name" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Last Name" => "string"}}
    end

    test "contact_type" do
      contact = %{"contact_type" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{}}
    end

    test "suffix" do
      contact = %{"suffix" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Suffix" => "string"}}
    end

    test "preferred_locale" do
      contact = %{"preferred_locale" => "en_US"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{}}
    end

    test "origin" do
      contact = %{"origin" => %{"date" => "2019-02-23T06:29:40.856Z", "ip_address" => "string"}}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{}}
    end

    test "empty custom_fields, to not trigger cache and need for API" do
      contact = %{"custom_fields" => []}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{}}
    end

    test "opt_in_reason" do
      contact = %{"opt_in_reason" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{}}
    end

    test "anniversary" do
      contact = %{"anniversary" => "2019-02-23T06:29:40.855Z"}

      assert Contact.from_rest(contact, "unused_token") ==
               {:ok, %{"Anniversary" => "2019-02-23T06:29:40.855Z"}}
    end

    test "addresses" do
      contact = %{
        "addresses" => [
          %{
            "country_code" => "country",
            "field" => "BILLING",
            "line1" => "street 1",
            "line2" => "street 2",
            "locality" => "city",
            "postal_code" => "postal",
            "region" => "state",
            "zip_code" => "zip",
            "zip_four" => "four"
          }
        ]
      }

      assert Contact.from_rest(contact, "unused_token") ==
               {:ok,
                %{
                  "Billing Address Street 1" => "street 1",
                  "Billing Address Street 2" => "street 2",
                  "Billing Address City" => "city",
                  "Billing Address State" => "state",
                  "Billing Address Postal Code" => "zip",
                  "Billing Address Zip Four" => "four",
                  "Billing Address Country" => "country"
                }}
    end

    test "spouse_name" do
      contact = %{"spouse_name" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Spouse Name" => "string"}}
    end

    test "website" do
      contact = %{"website" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Website" => "string"}}
    end

    test "last_updated" do
      contact = %{"last_updated" => "2019-02-23T06:29:40.856Z"}

      assert Contact.from_rest(contact, "unused_token") ==
               {:ok, %{"Last Updated" => "2019-02-23T06:29:40.856Z"}}
    end

    test "email_opted_in" do
      contact = %{"email_opted_in" => true}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{}}
    end

    test "prefix" do
      contact = %{"prefix" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Title" => "string"}}
    end

    test "time_zone" do
      contact = %{"time_zone" => "string"}
      assert Contact.from_rest(contact, "unused_token") == {:ok, %{"Time Zone" => "string"}}
    end

    test "phone_numbers" do
      contact = %{
        "phone_numbers" => [
          %{
            "extension" => "extension",
            "field" => "PHONE1",
            "number" => "number",
            "type" => "type"
          }
        ]
      }

      assert Contact.from_rest(contact, "unused_token") ==
               {:ok,
                %{"Phone 1" => "number", "Phone 1 Type" => "type", "Phone 1 Ext" => "extension"}}
    end

    test "birthday" do
      contact = %{"birthday" => "2019-02-23T06:29:40.855Z"}

      assert Contact.from_rest(contact, "unused_token") ==
               {:ok, %{"Birthday" => "2019-02-23T06:29:40.855Z"}}
    end

    test "Empty map returns without change" do
      assert Contact.from_rest(%{}, "unused_token") == {:ok, %{}}
    end

    test "from_address handles empty address list" do
      assert Contact.from_rest(%{"addresses" => []}, "unused_token") == {:ok, %{}}
    end

    test "from_address filters out all blank values" do
      addresses = [%{"field" => "BILLING", "line1" => "111 Sunny Ln.", "line2" => ""}]

      assert Contact.from_rest(%{"addresses" => addresses}, "unused_token") ==
               {:ok, %{"Billing Address Street 1" => "111 Sunny Ln."}}
    end
  end

  describe "to_ functions" do
    # 2/23/19 https://developer.infusionsoft.com/docs/rest/#!/Contact/updatePropertiesOnContactUsingPATCH_1
    test "addresses" do
      contact = %{
        "Billing Address Street 1" => "street 1",
        "Billing Address Street 2" => "street 2",
        "Billing Address City" => "city",
        "Billing Address State" => "state",
        "Billing Address Postal Code" => "zip",
        "Billing Address Zip Four" => "four",
        "Billing Address Country" => "country"
      }

      assert Contact.to_rest(contact, "unused_token") ==
               {:ok,
                %{
                  "addresses" => [
                    %{
                      "country_code" => "country",
                      "field" => "BILLING",
                      "line1" => "street 1",
                      "line2" => "street 2",
                      "locality" => "city",
                      "postal_code" => "zip - four",
                      "region" => "state",
                      "zip_code" => "zip",
                      "zip_four" => "four"
                    }
                  ]
                }}
    end

    test "anniversary" do
      contact = %{"Anniversary" => "2019-02-23T16:57:00.276Z"}

      assert Contact.to_rest(contact, "unused_token") ==
               {:ok, %{"anniversary" => "2019-02-23T16:57:00.276Z"}}
    end

    test "birthday" do
      contact = %{"Birthday" => "2019-02-23T16:57:00.276Z"}

      assert Contact.to_rest(contact, "unused_token") ==
               {:ok, %{"birthday" => "2019-02-23T16:57:00.276Z"}}
    end

    # Needs a mock
    # test "company" do
    #   contact = %{"Company" => "string"}

    #   assert Contact.to_rest(contact, "unused_token") ==
    #            {:ok, %{"company" => %{"id" => 0}}}
    # end

    test "contact_type" do
      contact = %{"Person Type" => "Vendor"}
      assert Contact.to_rest(contact, "unused_token") == {:ok, %{"contact_type" => "Vendor"}}
    end

    test "email_addresses" do
      contact = %{"Email" => "string"}

      assert Contact.to_rest(contact, "unused_token") ==
               {:ok, %{"email_addresses" => [%{"email" => "string", "field" => "EMAIL1"}]}}
    end

    test "family_name" do
      contact = %{"Last Name" => "string"}
      assert Contact.to_rest(contact, "unused_token") == {:ok, %{"family_name" => "string"}}
    end

    test "fax_numbers" do
      contact = %{"Fax 1" => "number", "Fax 1 Type" => "type"}

      assert Contact.to_rest(contact, "unused_token") ==
               {:ok,
                %{"fax_numbers" => [%{"field" => "FAX1", "number" => "number", "type" => "type"}]}}
    end

    test "given_name" do
      contact = %{"First Name" => "string"}
      assert Contact.to_rest(contact, "unused_token") == {:ok, %{"given_name" => "string"}}
    end

    test "job_title" do
      contact = %{"Job Title" => "string"}
      assert Contact.to_rest(contact, "unused_token") == {:ok, %{"job_title" => "string"}}
    end

    test "middle_name" do
      contact = %{"Middle Name" => "string"}
      assert Contact.to_rest(contact, "unused_token") == {:ok, %{"middle_name" => "string"}}
    end

    test "notes" do
      contact = %{"Person Notes" => "string"}
      assert Contact.to_rest(contact, "unused_token") == {:ok, %{"notes" => "string"}}
    end

    test "phone_numbers" do
      contact = %{"Phone 1" => "number", "Phone 1 Type" => "type", "Phone 1 Ext" => "extension"}

      assert Contact.to_rest(contact, "unused_token") ==
               {:ok,
                %{
                  "phone_numbers" => [
                    %{
                      "extension" => "extension",
                      "field" => "PHONE1",
                      "number" => "number",
                      "type" => "type"
                    }
                  ]
                }}
    end

    test "preferred_name" do
      contact = %{"Nickname" => "string"}
      assert Contact.to_rest(contact, "unused_token") == {:ok, %{"preferred_name" => "string"}}
    end

    test "prefix" do
      contact = %{"Title" => "string"}
      assert Contact.to_rest(contact, "unused_token") == {:ok, %{"prefix" => "string"}}
    end

    test "social_accounts" do
      contact = %{"Facebook" => "fb", "LinkedIn" => "li"}

      assert Contact.to_rest(contact, "unused_token") ==
               {:ok,
                %{
                  "social_accounts" => [
                    %{"name" => "fb", "type" => "Facebook"},
                    %{"name" => "li", "type" => "LinkedIn"}
                  ]
                }}
    end

    test "spouse_name" do
      contact = %{"Spouse Name" => "string"}
      assert Contact.to_rest(contact, "unused_token") == {:ok, %{"spouse_name" => "string"}}
    end

    test "suffix" do
      contact = %{"Suffix" => "string"}
      assert Contact.to_rest(contact, "unused_token") == {:ok, %{"suffix" => "string"}}
    end

    test "time_zone" do
      contact = %{"Time Zone" => "string"}
      assert Contact.to_rest(contact, "unused_token") == {:ok, %{"time_zone" => "string"}}
    end

    test "website" do
      contact = %{"Website" => "string"}
      assert Contact.to_rest(contact, "unused_token") == {:ok, %{"website" => "string"}}
    end

    # test "custom" do
    #   contact = %{"Some Custom Field" => "string"}

    #   assert Contact.to_rest(contact, "test_token") ==
    #            {:ok, %{"custom_fields" => [%{"id" => 0, "content" => "string"}]}}
    # end

    # test "no matching field" do
    #   contact = %{"Nonexistent Field" => "string"}

    #   assert Contact.to_rest(contact, "test_token") ==
    #            {:error, "Nonexistent Field is not implemented"}
    # end
  end
end
