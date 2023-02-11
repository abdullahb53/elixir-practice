number = 13
Macro.to_string(quote do: 11 + number)
# "11 + number"

number = 13
Macro.to_string(quote do: 11 + unquote(number))
# "11 + 13"

fun = :hello
Macro.to_string(quote do: unquote(fun)(:world))
# "hello(:world)"

inner = [3, 4, 5]
Macro.to_string(quote do: [1, 2, unquote(inner), 6])
# "[1, 2, [3, 4, 5], 6]"

inner = [3, 4, 5]
Macro.to_string(quote do: [1, 2, unquote_splicing(inner), 6])
# "[1, 2, 3, 4, 5, 6]"
