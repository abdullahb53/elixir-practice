defmodule Example do
  def add(a,b) do
    IO.puts(a + b)
  end
end

Example.add(2,3)

# spawn(Example, :add, [55,44])
# 99
# #PID<0.117.0>
