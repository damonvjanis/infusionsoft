defmodule Infusionsoft.Schemas.REST.ContactsTest do
  use ExUnit.Case, async: true
  doctest Infusionsoft.Schemas.REST.Contacts
  alias Infusionsoft.Schemas.REST.Contacts

  test "to function returns list of REST names" do
    assert Contacts.to(["First Name", "Last Name"], "test_token") ==
             {:ok, ["given_name", "family_name"]}
  end

  test "from function returns list of Common names" do
    assert Contacts.from(["given_name", "family_name"], "test_token") ==
             {:ok, ["First Name", "Last Name"]}
  end
end
