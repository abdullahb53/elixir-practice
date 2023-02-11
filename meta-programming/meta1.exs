# In Elixir the abstract syntax tree (AST),
# the internal representation of our code, is composed of tuples.
# These tuples contain three parts: function name, metadata,
# and function arguments.

denominator = 2

quote do: divide(42,denominator)
quote do: divide(42,unquote(denominator))

defmodule OurMacro do
  defmacro unless(expr, do: block) do
    quote do
      if !unquote(expr), do: unquote(block)
    end
  end
end

defmodule Main do
  require OurMacro

  def start do
    IO.puts(OurMacro.unless true, do: "Hi") # nil

    IO.puts(OurMacro.unless false, do: "Hi") # Hi
  end

end

Main.start()
