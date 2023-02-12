list = [1,2,3,4,5]
squared_list = for x <- list, do: x*x
# 1 4 9 16 25
IO.inspect(squared_list)


list2 = [1, 2, 3, 4, 5, 6]
new_list = for x <- list2, rem(x, 2) == 0, do: x
IO.inspect(new_list) # Output: [2, 4, 6]

## Keyword lists.
keywordLists = for {_key, val} <- [one: 1, two: 2, three: 3], do: val
IO.inspect(keywordLists) # [1, 2, 3]

## Maps.
for {k, v} <- %{"a" => "A", "b" => "B"}, do: {k, v}
# [{"a", "A"}, {"b", "B"}]

## Binaries.
for <<c <- "hello">>, do: <<c>>
# ["h", "e", "l", "l", "o"]


for {:ok, val} <- [ok: "Hello", error: "Unknown", ok: "World"], do: val
# ["Hello", "World"]

# # # # # #
# NESTED. #
#  # # #  #
list3 = [1,2,3,4,5,6,7]
res = for n <- list3, times <- 1..n do
  String.duplicate("*",times)
end

IO.inspect(res)

res = for n <- list, times <- 1..n, do: IO.puts "#{n} - #{times}"
IO.inspect(res)

import Integer

## Also and -> Erlang.
res = for x <- 1..100,
!is_even(x),
rem(x, 3) == 0, do: x

IO.inspect(res)
