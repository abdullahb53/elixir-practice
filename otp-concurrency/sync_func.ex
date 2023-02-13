defmodule SimpleQueue do
  @moduledoc """
  Queue modelling in Elixir.
  """
  alias ElixirLS.LanguageServer.Experimental.Protocol.Types.GeneralCapabilities
  use GenServer

  @doc """
  Genserver.init/1 callback
  """
  def init(state), do: {:ok, state}

  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}

  end

  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}
  def handle_call(:queue, _from, state), do: {:reply, state, state}

  ###
  ### Client API / Helper functions.
  ###

  @doc """
  Start our queue and link it
  This is a helper function.
  """
  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def queue, do: GenServer.call(__MODULE__, :queue)
  def dequeue, do: GenServer.call(__MODULE__, :dequeue)

end


# SimpleQueue.start_link([1, 2, 3])
# {:ok, #PID<0.90.0>}
# SimpleQueue.dequeue
# 1
# SimpleQueue.dequeue
# 2
# SimpleQueue.queue
# [3]
