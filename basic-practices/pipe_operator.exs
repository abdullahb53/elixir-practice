# Pipe operator: |>
"Elixir rocks" |> String.split() # ["Elixir", "rocks"]

"Elixir rocks" |> String.upcase() |> String.split() # ["ELIXIR", "ROCKS"]

"elixir" |> String.ends_with?("ixir") # true
