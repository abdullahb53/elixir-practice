defmodule Greeter do


  def hello(names) when is_list(names) do
    names = Enum.join(names,", ")
    IO.puts(names)
  end

  defp phrase(), do: "STR, "

  def hello(names) when is_binary(names) do
    res = phrase() <> names
    IO.puts(res)
  end

  def hello(_) do
    IO.puts("Unexpected statement.")
  end


end


Greeter.hello(["Sean", "Steve"])
