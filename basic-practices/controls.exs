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

# with.
user = %{first: "doomspork"} # error
user = %{first: "Sean", last: "Callan"} # Callan, Sean

with  {:ok, first} <- Map.fetch(user, :first),
      {:ok, last} <- Map.fetch(user, :last) do
      resp = last <> ", " <> first
      IO.puts(resp)
end

# @@@@@@ Big "with" example without with!. @@@@@@
# case Repo.insert(changeset) do
#   {:ok, user} ->
#     case Guardian.encode_and_sign(user, :token, claims) do
#       {:ok, token, full_claims} ->
#         important_stuff(token, full_claims)

#       error ->
#         error
#     end

#   error ->
#     error
# end
#
# @@@@@@@@@@@@@@@@ With "with"... @@@@@@@@@@@@@@@@
#
# with {:ok, user} <- Repo.insert(changeset),
#      {:ok, token, full_claims} <- Guardian.encode_and_sign(user, :token, claims) do
#   important_stuff(token, full_claims)
# end

# "with" supported else after 1.3

import Integer

m = %{a: 3, b: 44}

a=
  with  {:ok,number} <- Map.fetch(m,:c), true <- is_even(number) do
        IO.puts "#{number} divided by 2 is #{div(number,2)}"
        :even
    else
      :error ->
        IO.puts("We don't have this item in map.")
        :error
      _ ->
        IO.puts("It is odd")
        :odd
  end
