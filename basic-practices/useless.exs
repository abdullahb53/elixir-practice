IO.puts("Hello World from Elixir")

a = [1,2,3,3,4,4,4,5,6] -- [4,3,4,5,1]
IO.puts(inspect(a))

map = %{:foo => "bar"}
keyword_lists = [foo: "bar", hello: "world"]
tuples = {3.14, :pie, "Apple"}
