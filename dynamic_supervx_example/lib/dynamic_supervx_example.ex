defmodule DynamicSupervxExample do
  use GenServer
  @moduledoc """
  Documentation for `DynamicSupervxExample`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DynamicSupervxExample.hello()
      :world

  """
  @me __MODULE__
  def start_link(opts) do
    IO.puts("Child: DynamicSupervxExample -start_link/1")
    GenServer.start_link(@me, :ok, opts)
  end

  @impl true
  def init(:ok) do
    IO.puts("Child: DynamicSupervxExample -init/1")
    Process.send_after(self(), :hello, 1000)
    {:ok, %{}}
  end

  @impl true
  def handle_info(:hello, state) do
    IO.puts("Child: DynamicSupervxExample -handle_info(:hello) -> Hello world.")


    Process.send_after(self(), :hello, 1000)
    {:noreply, state}
  end

  @impl true
  def handle_info(_,state) do
    {:noreply, state}
  end

end
