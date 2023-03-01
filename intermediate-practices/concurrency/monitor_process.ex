defmodule Example do
    def explode, do: exit(:bummm)

    def run do
      # monitoring.
      {pid,ref} = spawn_monitor(Example, :explode, [])

      receive do
        {:DOWN, ref, :process, from_pid, reason} -> IO.puts("Exit reason #{reason}")
          # code
      end
    end

end

# iex(3)> Example.run
# Exit reason bummm
# :ok
# iex(4)>
