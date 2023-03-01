defmodule DynamicSupervxExampleTest do
  use ExUnit.Case
  doctest DynamicSupervxExample

  test "greets the world" do
    assert DynamicSupervxExample.hello() == :world
  end
end
