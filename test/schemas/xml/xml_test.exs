defmodule Infusionsoft.Schemas.XMLTest do
  use ExUnit.Case, async: true
  doctest Infusionsoft.Schemas.XML

  test "greets the world" do
    assert Infusionsoft.Schemas.XML.hello() == :world
  end
end
