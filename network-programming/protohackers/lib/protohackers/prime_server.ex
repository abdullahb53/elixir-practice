defmodule Protohackers.PrimeServer do
  use GenServer

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
        Logger.info("Starting prime server on port 5002")
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
    case echo_lines_until_closed(socket) do
      :ok -> :ok
      {:error, reason} -> Logger.error("Failed to receive data: #{inspect(reason)}")
      # {:error, reason} -> Logger.error("Failed to receive data: #{inspect(reason)}")
    end

    :gen_tcp.close(socket)
  end


  defp echo_lines_until_closed(socket) do
     case :gen_tcp.recv(socket, 0, 10_1000) do
      {:ok, data} ->
        case Jason.decode(data) do
          {:ok, %{"method" =>"isPrime", "number" => number}} when is_number(number) ->
            Logger.debug("Received valid request for number: #{inspect(number)}")
            response = %{"method" => "isPrime", "prime" => prime?(number)}
            :gen_tcp.send(socket, [Jason.encode!(response), ?\n])
            echo_lines_until_closed(socket)


          # {:ok, json} ->
          #   Logger.debug("Received data: #{inspect(json)}")
          #   :gen_tcp.send(socket, [Jason.encode!(json), ?\n])
          #   echo_lines_until_closed(socket)

          other ->
            Logger.debug("Received invalid request. Reason is: #{inspect(other)}")
            :gen_tcp.send(socket, "malformed request@@@ \n")
            {:error, :invalid_request}
        end


      {:error, :closed} ->
        :ok

      {:error, reason} ->
        {:ok, reason}
     end
  end

  # Prime function.
  defp prime?(number) when is_float(number), do: false
  defp prime?(number) when number <= 1, do: false
  defp prime?(number) when number in [2,3], do: true

  defp prime?(number) do
    not Enum.any?(2..trunc(:math.sqrt(number)), &(rem(number, &1) == 0))
  end

end
