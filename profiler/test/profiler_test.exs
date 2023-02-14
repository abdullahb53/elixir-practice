defmodule ProfilerTest do
  use ExUnit.Case
  doctest Profiler

  test "greets the world" do
    assert Profiler.hello() == :world
  end
end
