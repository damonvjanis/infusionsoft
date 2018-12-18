defmodule Infusionsoft.Schemas.ContactsTest do
  use ExUnit.Case, async: true
  doctest Infusionsoft.Schemas.Contacts
  alias Infusionsoft.Schemas.Contacts

  test "common_to_rest" do
    assert map_size(Contacts.common_to_rest()) == map_size(Contacts.rest_to_common())
  end

  test "common_to_rest_downcase" do
    assert Contacts.common_to_rest_downcase() != Contacts.common_to_rest()
    assert map_size(Contacts.common_to_rest_downcase()) == map_size(Contacts.common_to_rest())

    assert Contacts.common_to_rest_downcase() |> Map.keys() ==
             Contacts.common_to_rest() |> Map.keys() |> Enum.map(&String.downcase/1)
  end

  test "rest_to_common" do
    assert map_size(Contacts.rest_to_common()) == map_size(Contacts.common_to_rest())
    assert Contacts.rest_to_common() != Contacts.common_to_rest()
  end

  test "common_to_xml" do
    assert map_size(Contacts.common_to_xml()) == map_size(Contacts.xml_to_common())
  end

  test "common_to_xml_downcase" do
    assert Contacts.common_to_xml_downcase() != Contacts.common_to_xml()
    assert map_size(Contacts.common_to_xml_downcase()) == map_size(Contacts.common_to_xml())

    assert Contacts.common_to_xml_downcase() |> Map.keys() ==
             Contacts.common_to_xml() |> Map.keys() |> Enum.map(&String.downcase/1)
  end

  test "xml_to_common" do
    assert map_size(Contacts.xml_to_common()) == map_size(Contacts.common_to_xml())
    assert Contacts.xml_to_common() != Contacts.common_to_xml()
  end

  test "list_names functions" do
    assert length(Contacts.list_common_names()) == length(Contacts.list_rest_names())
    assert length(Contacts.list_common_names()) == length(Contacts.list_xml_names())
  end
end
