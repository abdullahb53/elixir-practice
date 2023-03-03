defmodule HandleTcpExample.GetLocations do
  use GenServer

  require Logger

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :no_state)
  end

  defstruct [:socket]

  @impl true
  def init(:no_state) do

    case :gen_udp.open(5005,[:binary, active: false, recbuf: 1000, ip: {127,0,0,1}]) do
      {:ok, udp_socket} ->
        Logger.debug("Udp socket created on 5005")
        state = %__MODULE__{socket: udp_socket}
        {:ok, state, {:continue, :recv}}
    end

  end

  @impl true
  def handle_continue(:recv, %__MODULE__{} = state) do

    case :gen_udp.recv(state.socket,0) do
      {:ok, {address, port, packet}} ->
        Logger.debug("Received UDP packet from #{inspect(address)}:#{inspect(port)}: Message: #{inspect(packet)}")
        {:noreply, state, {:continue, :recv}}

      {:error, reason} ->
        Logger.error(":gen_udp.recv('...') error: #{inspect(reason)}")
        {:stop, reason}

    end

  end

end
