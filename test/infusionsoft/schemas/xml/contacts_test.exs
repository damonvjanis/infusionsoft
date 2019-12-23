defmodule Infusionsoft.Schemas.XML.ContactsTest do
  use ExUnit.Case, async: true
  doctest Infusionsoft.Schemas.XML.Contact
  alias Infusionsoft.Schemas.XML.Contact

  test "to function returns list of XML names" do
    assert Contact.to(["First Name", "Last Name"], "test_token", "test_app") ==
             {:ok, ["FirstName", "LastName"]}
  end

  test "from function returns list of Common names" do
    assert Contact.from(["FirstName", "LastName"], "test_token", "test_app") ==
             {:ok, ["First Name", "Last Name"]}
  end
end
