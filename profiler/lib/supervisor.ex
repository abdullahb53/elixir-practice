defmodule Profiler.Supervisor do
  use Supervisor

  def start_link(opts) do
    IO.puts("Supervisor start_link/1")
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    IO.puts("Supervisor init/1")

    children = [
      {Profiler.Manager,  [name: Profiler.Manager]},
      {Profiler.GithubWorker,  [name: Profiler.GithubWorker]},
      {Profiler.AgeWorker,  [name: Profiler.AgeWorker]},
    ]

    Supervisor.init(children, strategy: :one_for_one)

  end

end
