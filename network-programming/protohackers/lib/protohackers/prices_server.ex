defmodule Protohackers.PricesServer do
  use GenServer

  alias Protohackers.PricesServer.Db

  require Logger

  def start_link([] =_opts) do
    GenServer.start_link(__MODULE__, :no_state )
  end

  defstruct [:listen_socket, :supervisor]

  @impl true
  def init(:no_state) do
    {:ok, supervisor} = Task.Supervisor.start_link(max_children: 100)

    listen_options = [
      mode: :binary,
      active: false,
      reuseaddr: true,
      exit_on_close: false,
      packet: :line,
      # Pass the buffer size to options.
      buffer: 1024 * 100
    ]



    case :gen_tcp.listen(5002, listen_options) do
      {:ok, listen_socket} ->
        # Gets buffer size.
        # dbg(:inet.getopts(listen_socket, [:buffer]))
        Logger.info("Starting prices server on port 5002")
        state = %__MODULE__{listen_socket: listen_socket, supervisor: supervisor}
        {:ok, state, {:continue, :accept}}

      {:error, reason} ->
        {:stop, reason}
    end
  end

  @impl true
  def handle_continue(:accept, %__MODULE__{} = state) do
    case :gen_tcp.accept(state.listen_socket) do
      {:ok, socket} ->
        Task.Supervisor.start_child(state.supervisor, fn -> handle_connection(socket) end)
        {:noreply, state, {:continue, :accept}}

      {:error, reason} ->
        {:stop, reason, state}
    end
  end

  # Helpers
  defp handle_connection(socket) do
    case handle_requests(socket, Db.new()) do
      :ok -> :ok
      {:error, reason} -> Logger.error("Failed to receive data: #{inspect(reason)}")
    end

    :gen_tcp.close(socket)
  end


  defp handle_requests(socket, db) do
     case :gen_tcp.recv(socket, 9, 10_1000) do
      {:ok, data} ->
        case handle_request(data, db) do
          {nil, db} ->
            handle_requests(socket, db)

          {response, db} ->
            :gen_tcp.send(socket, response)
            handle_requests(socket, db)

            :error ->
              {:error, :invalid_request}
        end

      {:error, :timeout} ->
        handle_requests(socket, db)

      {:error, :closed} ->
        :ok

      {:error, reason} -> # not 9 byte tracker.. we discard it "on recv func" -> when byte_size(data) == 9
        {:ok, reason}
     end


  end

  defp handle_request(<<?I, timestamp::32-signed-big, price::32-signed-big>>, db) do
        {nil, Db.add(db, timestamp, price)}
  end

  defp handle_request(_other, _db) do
    :error
  end


end
