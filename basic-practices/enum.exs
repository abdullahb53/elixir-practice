defmodule BobDoSomething do
  def exclusive_print(x) do
    IO.puts(inspect(x))
  end
end

# Enum
IO.puts(Enum.all?(["ba","for","while","break","pop"], fn (s) -> String.length(s) > 2  end)) # false
IO.puts(Enum.all?(["banana","for","while","break","pop"], fn (s) -> String.length(s) > 2  end)) # true

IO.puts(Enum.any?(["321","abc","1","0"], fn (s) -> String.length(s) == 2 end)) # false
IO.puts(Enum.any?(["321","abc","12","0"], fn (s) -> String.length(s) == 2 end)) # true

IO.puts(  inspect(  Enum.chunk_every([1,2,3,4,5,6], 4)  )   ) # [[1, 2, 3, 4], [5, 6]]

BobDoSomething.exclusive_print(
  Enum.chunk_by(["one", "two", "three", "four", "five","six"], fn (x) -> String.length(x) end)
) # [["one", "two"], ["three"], ["four", "five"], ["six"]]

BobDoSomething.exclusive_print(
  Enum.map_every([1,2,3,4,5,6,7,8,9],3,fn x -> x + 100 end )
) # [101, 2, 3, 104, 5, 6, 107, 8, 9]

Enum.each([1,2,3,4,5],fn x -> IO.puts(x) end)

# Generating new collection.
BobDoSomething.exclusive_print(
  Enum.map([2,4,6,8,10],fn x -> x*x  end)
) # [4, 16, 36, 64, 100]

# Finds the minimal value.
BobDoSomething.exclusive_print(
  Enum.min([1,3,4,6,8,12,3,1,2,3,-888])
) # -888

# Finds the minimal value. (/2)
BobDoSomething.exclusive_print(
  Enum.min([], fn -> :foo end)
) # Finally, if you don't want to raise on empty enumerables, you can pass the empty fallback

BobDoSomething.exclusive_print(
  Enum.filter([1,2,3,4,5,6],fn x -> rem(x,2) == 0 end)
) # [2, 4, 6]

BobDoSomething.exclusive_print(
  Enum.reduce([1,2,3],10,fn(x,acc) -> x + acc end)
) # 16

BobDoSomething.exclusive_print(
  Enum.reduce([1,2,3],fn(x,acc) -> x + acc end)
) # 6

BobDoSomething.exclusive_print(
  Enum.sort([1,2,3,9,8,7])
) # [1, 2, 3, 7, 8, 9]

BobDoSomething.exclusive_print(
  Enum.sort([%{:val => 4},%{:val => 1}], fn (x,y) -> x[:val] > y[:val] end)
) # [%{val: 4}, %{val: 1}]

BobDoSomething.exclusive_print(
  Enum.sort([%{count: 4},%{count: 1}])
) # [%{count: 1}, %{count: 4}]

BobDoSomething.exclusive_print(
  Enum.uniq([1,1,1,1,1,1,2,2,2,2,3,3,3,4,4,4,4,4])
) # [1, 2, 3, 4]

BobDoSomething.exclusive_print(
  Enum.map([1,2,3], &(&1 + 3))
) # [4, 5, 6]
