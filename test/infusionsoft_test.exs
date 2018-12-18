defmodule InfusionsoftTest do
  use ExUnit.Case, async: true
  doctest Infusionsoft

  test "greets the world" do
    assert Infusionsoft.hello() == :world
  end
end
