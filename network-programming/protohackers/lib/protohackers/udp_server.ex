defmodule Protohackers.UdpServer do
  use GenServer

  require Logger

  def start_link([] = _opts) do
    GenServer.start_link(__MODULE__, :no_state)
  end

  defstruct [:socket, store: %{}]

  @impl true
  def init(:no_state) do
    Logger.info("Starting UDP server on port 5005")


    case :gen_udp.open(5005, [:binary, active: false, recbuf: 1000]) do
      {:ok, socket} ->
        state = %__MODULE__{socket: socket}
        {:ok, state, {:continue, :recv}} # trigger to recv on handle_continue

      {:error, reason} ->
        {:stop, reason}
    end

  end


  @impl true
  def handle_continue(:recv, %__MODULE__{} = state) do
    # :gen_tcp.accept -> :gen_udp.recv difference!
    case :gen_udp.recv(state.socket, 0) do
      {:ok, {address, port, packet} } ->
        Logger.debug("Received UDP packet from #{inspect(address)}:#{inspect(port)}: #{inspect(packet)}")

        {:noreply, state, {:continue,:recv}}

      {:error, reason} ->
        {:stop, reason}


    end

  end

end
