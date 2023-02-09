defmodule Greeter do


  def hello(names) when is_list(names) do
    names = Enum.join(names,", ")

    hello(names)
  end

  def hello(names) when is_binary(names) do
    phrase() <> names

  end

  def hello(_) do
    IO.puts("Unexpected statement.")
  end

  defp phrase(), do: "Hello, "

end


IO.puts(Greeter.hello(["Sean", "Steve"]))
