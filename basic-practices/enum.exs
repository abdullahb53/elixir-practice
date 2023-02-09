# Enum
IO.puts(Enum.all?(["ba","for","while","break","pop"], fn (s) -> String.length(s) > 2  end)) # false
IO.puts(Enum.all?(["banana","for","while","break","pop"], fn (s) -> String.length(s) > 2  end)) # true

IO.puts(Enum.any?(["321","abc","1","0"], fn (s) -> String.length(s) == 2 end)) # false
IO.puts(Enum.any?(["321","abc","12","0"], fn (s) -> String.length(s) == 2 end)) # true

IO.puts(  inspect(  Enum.chunk_every([1,2,3,4,5,6], 4)  )   ) # [[1, 2, 3, 4], [5, 6]]

IO.puts(
  inspect(
    Enum.chunk_by(["one", "two", "three", "four", "five","six"], fn (x) -> String.length(x) end)
  )
) # [["one", "two"], ["three"], ["four", "five"], ["six"]]

IO.puts(
  inspect(
    Enum.map_every([1,2,3,4,5,6,7,8,9],3,fn x -> x + 100 end )
  )
) # [101, 2, 3, 104, 5, 6, 107, 8, 9]
