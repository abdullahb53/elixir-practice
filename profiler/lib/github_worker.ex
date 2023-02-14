defmodule Profiler.GithubWorker do
  use GenServer

  @me __MODULE__
  def start_link(opts) do
    IO.puts("GithubWorker start_link/1")
    GenServer.start_link(@me, :ok, opts)
  end

  @impl true
  def init(:ok) do
    IO.puts("GithubWorker init/1")
    Process.send_after(self(), :refresh, 1000)
    {:ok, %{}}
  end

  @impl true
  def handle_call(:profile, _caller, state) do
    {:reply, state, state}
  end

  @imple true
  def handle_info(:refresh , _state) do
    IO.puts("GithubWorker handle_info(:refresh, state)")

    #  {:ok, %HTTPoison.Response{status_code: 200, body: "{\"login\":\"abdullah
    HTTPoison.start()
    IO.puts("HTTPoison Req starting..: https://api.github.com/users/abdullahb53")
    {:ok, response} = HTTPoison.get("https://api.github.com/users/abdullahb53")
    IO.puts("HTTP req end. ")
    response_body = response.body
    response = Jason.decode!(response_body)


    new_state = Map.take(response,["name","blog","avatar_url"])
    GenServer.cast(Profiler.Manager, {:update_and_merge, new_state})

    Process.send_after(self(), :refresh, 10000)

    {:noreply, new_state}
  end

  @imple true
  def handle_info(_,state) do
    {:noreply, state}
  end

end
