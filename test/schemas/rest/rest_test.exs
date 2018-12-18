defmodule Infusionsoft.Schemas.RESTTest do
  use ExUnit.Case, async: true
  doctest Infusionsoft.Schemas.REST

  test "greets the world" do
    assert Infusionsoft.Schemas.REST.hello() == :world
  end
end
