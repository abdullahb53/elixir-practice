defmodule Profiler.Manager do
  use GenServer

  @me __MODULE__

  def start_link(opts) do
    IO.puts("Manager start_link/1")
    GenServer.start_link(@me, :ok, opts)
  end

  def profile do
    IO.puts("GenServer.call(@me, :profile)")
    GenServer.call(@me, :profile)
  end

  @impl true
  def init(:ok) do
    IO.puts("Manager init/1")
    {:ok, %{}}
  end

  @impl true
  def handle_call(:profile, _caller, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:update_and_merge, caller, data}, state) do
    IO.inspect("#{caller} want to merge #{inspect(data)}")
    new_state = Map.merge(state, data)
    {:noreply, new_state}
  end

  @impl true
  def handle_info(_, state) do
    {:noreply, state}
  end

end
