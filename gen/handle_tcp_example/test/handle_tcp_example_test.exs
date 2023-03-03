defmodule HandleTcpExampleTest do
  use ExUnit.Case
  doctest HandleTcpExample

  test "greets the world" do
    assert HandleTcpExample.hello() == :world
  end
end
