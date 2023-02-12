# Using into.
res = for {k, v} <- [one: 1, two: 2, three: 3], into: %{}, do: {k,v}
IO.inspect(res)
# %{one: 1, three: 3, two: 2}

res = for c <- [73, 101, 108, 108, 111], into: "", do: <<c>>
IO.inspect(res)
"Iello"
