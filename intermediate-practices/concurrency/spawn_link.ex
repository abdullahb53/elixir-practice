defmodule Example do
  def explode, do: exit(:bummm)
end
# spawn(Example, :explode, [])
# #PID<0.66.0>

# spawn_link(Example, :explode, [])
# ** (EXIT from #PID<0.57.0>) evaluator process exited with reason: :kaboom
#
#
#
#
defmodule Example2 do
  def explode, do: exit(:bummm)
  def run() do
    Process.flag(:trap_exit, true)
    spawn_link(Example,:explode,[])

    receive do
      {:EXIT, from_pid, reason} -> IO.puts("Exit reason #{reason}")
        # code
    end

  end
end
# Example2.run
# Exit reason: bummm
# :ok
