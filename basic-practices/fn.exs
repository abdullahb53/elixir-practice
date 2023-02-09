f = fn
  x,y when x>0 -> x+y
  x,y -> x*y
end
atom1 = f.(1,3)
IO.puts("12312 #{atom1}")
f.(-1,3)
