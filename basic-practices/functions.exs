# Normal function.
defmodule Module1 do
  def func1(name) do
      IO.puts "Hello, " <> name
  end
end

Module1.func1("Abdullah")


# Recursion example with func.
defmodule Lenght do
  def of([]), do: 0
  def of([_|tail]), do: 1 + of(tail)
end

s1 = Lenght.of []
s2 = Lenght.of [1,2,3,4,5]
IO.puts("s1:#{s1}, s2:#{s2}")


# Function Naming and Arity -> This is about Erlang information(same function behaves different action with different arguments.)
defmodule Module2 do

  def func1() do
    IO.puts("func1() - 'No' argument.")
  end

  def func1(arg1) do
    IO.puts("func1(1) - 'One' argument.")
  end

  def func1(arg1,arg2) do
    IO.puts("func1(1,2) - 'Two' Arguments.")
  end

end

Module2.func1()
Module2.func1(:a)
Module2.func1(:a,:b)
