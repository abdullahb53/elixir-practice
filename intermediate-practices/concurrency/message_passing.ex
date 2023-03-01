defmodule Example do
  def listen do
    receive do
      {:ok, "hello"} -> IO.puts("World")
    end

    listen # infinite loop, i learned that Erlang doc.
  end
end

# iex(4)> pid = spawn(Example, :listen,[])
# #PID<0.126.0>
# iex(5)> send pid, {:ok, "hello"}
# World
# {:ok, "hello"}
