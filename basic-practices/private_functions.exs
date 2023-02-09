# Private functions.
defmodule Greeter do

  def hello(name), do: phrase() <> name
  defp phrase, do: "Hello, "

end

a = Greeter.hello("Abdullah")
IO.puts(a)

# Greeter.phrase -> u cannot do that like this. Because that func. is private.
