defmodule MySupervisor do
  use GenServer

  ## API
  def start_link(child_spec_list) do
    GenServer.start_link(__MODULE__, child_spec_list)
  end

  def list_processes(pid) do
    GenServer.call(pid, :list)
  end

  ## OTP Callbacks
  def init(child_spec_list) do
    Process.flag(:trap_exit, true)
    state = child_spec_list
    |> Enum.map(&start_child/1)
    |> Enum.into(%{})
    {:ok, state}
  end

  def handle_call(:list, _from, state) do
    {:reply, state, state}
  end

  ## Private Helper Functions
  defp start_child({module, function, args} = spec) do
    {:ok, pid} = apply(module, function, args)
    Process.link(pid)
    {pid, spec}
  end
end
