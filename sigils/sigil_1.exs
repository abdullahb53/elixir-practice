re = ~r/elixir/
~r/elixir/

"Elixir" =~ re
false

"elixir" =~ re
true



# Elixir supports Perl Compatible Regular Expressions (PCRE),
# we can append i to the end of our sigil to turn off case sensitivity.
re = ~r/elixir/i
~r/elixir/i

"Elixir" =~ re
true

"elixir" =~ re
true




~c/2 + 7 = #{2 + 7}/
'2 + 7 = 9'

~C/2 + 7 = #{2 + 7}/
'2 + 7 = \#{2 + 7}'



string = "100_000_000"
"100_000_000"

Regex.split(~r/_/, string)
["100", "000", "000"]




~s/the cat in the hat on the mat/
"the cat in the hat on the mat"

~S/the cat in the hat on the mat/
"the cat in the hat on the mat"




~s/welcome to elixir #{String.downcase "SCHOOL"}/
"welcome to elixir school"

~S/welcome to elixir #{String.downcase "SCHOOL"}/
"welcome to elixir \#{String.downcase \"SCHOOL\"}"




### Word List
~w/i love elixir school/
["i", "love", "elixir", "school"]

~W/i love elixir school/
["i", "love", "elixir", "school"]




NaiveDateTime.from_iso8601("2015-01-23 23:50:07") == {:ok, ~N[2015-01-23 23:50:07]}
