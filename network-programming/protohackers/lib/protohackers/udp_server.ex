defmodule Protohackers.UdpServer do
  use GenServer

  require Logger

  def start_link([] = _opts) do
    GenServer.start_link(__MODULE__, :no_state)
  end

  defstruct [:socket, store: %{"version" => "Protohackers in Elixir v1"}]

  @impl true
  def init(:no_state) do
    address =
      case System.fetch_env("FLY_APP_NAME") do
      {:ok, fly_global_ip} ->
        :inet.getaddr(~c"fly-global-services", :inet)
        fly_global_ip

        :error ->{0,0,0,0}
      end

    Logger.info("Starting UDP server on ${:inet.ntoa(address)}:5005")


    case :gen_udp.open(5005, [:binary, active: false, recbuf: 1000, ip: address]) do
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


        state =
           case String.split(packet,"=", parts: 2) do
            # Don't do anything fpr the "version" key.
            ["version", _value] ->
              state

            [key, value] ->
              Logger.debug("Inserted key #{inspect(key)} with value #{inspect(value)}")
              put_in(state.store[key], value)

            [key] ->
              Logger.debug("Requested y: #{inspect(key)}")
              packet = "#{key}=#{state.store[key]}"
              IO.puts(inspect(packet))
              # :gen_udp.connect() -> there is a way to not have to use a address import here which is by using gen UDP connect. you can connect the socket that you have opened to a specific address but the only thing that does is stores that address in  the socket  and then that socket is kind of bound to only talk to that address so by sending and receiving only from that adress but it's the thing that's done by genydp it's really just storing the adress in there and making sure that the data only comes and goes there but in our case we can just reply to the client that us sent us the request in this case.
              :gen_udp.send(state.socket, address, port, packet)
              state
           end

        {:noreply, state, {:continue,:recv}}

      {:error, reason} ->
        {:stop, reason}


    end

  end

end
