# if statement.
if String.valid?("Hi dude!") do
  IO.puts("Valid string")
else
  IO.puts("Invalid string")
end

unless is_integer("hello") do
  IO.puts("Not an INT")
end

# Erlang! USE THAT!
case {:ok,"Hello World"} do
  {:ok, result} -> IO.puts(result)
  {:error} -> IO.puts("some problems!")
   _ -> IO.puts("Unexpected statement.")
end

# i dont like bet. Important!
pi = 3.14
case "cheery piee" do
  ^pi -> IO.puts("yes, you are pi")
  qwe when is_atom(qwe) == true -> IO.puts("is binary i think not")
  piee -> IO.puts("I bet #{piee} is ...")
  _ -> IO.puts("Unexpected statement.")
end

# cond.
cond do
  2 + 2 == 5 ->
    IO.puts("Not true")
  2 * 2 == 3 ->
    IO.puts("Nor this")
  1+1 == 2 ->
    IO.puts("true!")
  true ->
    IO.puts("Catch all")
end
