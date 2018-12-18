defmodule Infusionsoft.SchemasTest do
  use ExUnit.Case, async: true
  doctest Infusionsoft.Schemas

  alias Infusionsoft.Schemas

  describe "REST functions" do
    test "to_rest function returns a list of REST names or an error message" do
      assert Schemas.to_rest(["First Name", "Last Name"], "test_token", :contacts) ==
               {:ok, ["given_name", "family_name"]}

      assert Schemas.to_rest(["First Name", "Last Name"], "test_token", :not_a_valid_type) ==
               {:error, "The type \"not_a_valid_type\" is invalid"}
    end

    test "from_rest function returns a list of Common names or an error message" do
      assert Schemas.from_rest(["given_name", "family_name"], "test_token", :contacts) ==
               {:ok, ["First Name", "Last Name"]}

      assert Schemas.from_rest(["given_name", "family_name"], "test_token", :not_a_valid_type) ==
               {:error, "The type \"not_a_valid_type\" is invalid"}
    end
  end

  describe "XML functions" do
    test "to_xml function returns a list of XML names or an error message" do
      assert Schemas.to_xml(["First Name", "Last Name"], "test_token", :contacts) ==
               {:ok, ["FirstName", "LastName"]}

      assert Schemas.to_xml(["First Name", "Last Name"], "test_token", :some_invalid_type) ==
               {:error, "The type \"some_invalid_type\" is invalid"}
    end
  end
end
