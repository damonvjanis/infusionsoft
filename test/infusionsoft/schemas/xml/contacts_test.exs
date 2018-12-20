defmodule Infusionsoft.Schemas.XML.ContactsTest do
  use ExUnit.Case, async: true
  doctest Infusionsoft.Schemas.XML.Contacts
  alias Infusionsoft.Schemas.XML.Contacts

  test "to function returns list of XML names" do
    assert Contacts.to(["First Name", "Last Name"], "test_token") ==
             {:ok, ["FirstName", "LastName"]}
  end

  test "from function returns list of Common names" do
    assert Contacts.from(["FirstName", "LastName"], "test_token") ==
             {:ok, ["First Name", "Last Name"]}
  end
end
