string = <<104,101,108,108,111>>
IO.puts(string) # hello

a = string <> <<0>>
IO.inspect(a) # <<104, 101, 108, 108, 111, 0>>
