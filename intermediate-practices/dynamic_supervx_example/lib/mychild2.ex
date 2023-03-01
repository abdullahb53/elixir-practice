defmodule Mychild2 do
  use GenServer

  @me __MODULE__
  def start_link(opts) do
    IO.puts("Child: Mychild2 -start_link/1")

    GenServer.start_link(@me, :ok, opts)


  end

  @impl true
  def init(:ok) do
    IO.puts("Child: Mychild2 -init/1")
    Process.send_after(self(), :mykid, 1000)
    Process.send_after(self(), :startmychild, 1000)
    {:ok, %{}}

  end

  @impl true
  def handle_info(:mykid, state) do
    IO.puts("Child: Mychild2 -handle_info(:mykid) -> I AM KID ! ! ! ! !")


    Process.send_after(self(), :mykid, 2000)
    {:noreply, state}
  end

  def handle_info(:startmychild, state ) do
    # Start child with dynamically
    DynamicSupervisor.start_child(DynamicSupervxExample.Supervisor, DynamicSupervxExample)
    IO.puts("Child process Hello World started..!")

    {:noreply, state}
  end

  @impl true
  def handle_info(_, state) do

    {:noreply, state}
  end

end
