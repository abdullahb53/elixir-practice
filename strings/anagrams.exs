defmodule AnagramExample do
  @moduledoc """
  Calculate ANagram statement.
  """

  @doc """
  Let’s first look at anagrams?/2. We are checking whether the parameters we are receiving are binaries or not.
  That’s the way we check if a parameter is a String in Elixir.
  """
  def anagrams?(a,b) when is_binary(a) and is_binary(b) do
    sort_string(a) == sort_string(b)
  end

  def sort_string(string) do
    string
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end

end


res = AnagramExample.anagrams?("Hello", "ohell")
IO.puts(res) # trues

Anagram.anagrams?(3, 5) # error
