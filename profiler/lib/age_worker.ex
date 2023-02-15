defmodule Profiler.AgeWorker do
  use GenServer

  @me __MODULE__
  def start_link(opts) do
      IO.puts("AgeWorker start_link/1.")
      GenServer.start_link(@me, :ok, opts)
  end

  @impl true
  def init(:ok) do
    IO.puts("AgeWorker init/1.")
    Process.send_after(self(), :refresh, 1000)
    {:ok, %{}}
  end

  @impl true
  def handle_call(:profile, _caller, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_info(:refresh, _state) do
    IO.puts("AgeWorker handle_info(:refresh, _state)")

    # {"age":54,"count":163557,"name":"pedro"}
    %{body: body} = Profiler.AgeApi.age("pedro")
    IO.inspect(body)
    new_state = Map.take(body, ["age"])
    IO.puts("ageworker @@@@ Map.take(body, [age])")
    IO.inspect(new_state)
    GenServer.cast(Profiler.Manager, {:update_and_merge, @me, new_state})

    Process.send_after(self(), :refresh, 60000)

    {:noreply, new_state}
  end

  @impl true
  def handle_info(_, state) do
    {:noreply, state}
  end

end
