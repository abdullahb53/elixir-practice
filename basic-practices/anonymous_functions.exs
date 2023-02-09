# Anonymous function.
sum = fn (a,b) -> a + b end
sum = sum.(4,2)
IO.puts("sum: #{sum}")

# An. Func. with shorthand.
sum2 = &(&1 + &2)
sum2 = sum2.(4,8)
IO.puts("sum2: #{sum2}")
