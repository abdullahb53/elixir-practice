defmodule DynamicSupervxExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    IO.puts("DynamicSupervxExample.Application -start/2")
    # children = [
    #   {DynamicSupervxExample, [name: DynamicSupervisor]},
    #   {Mychild2, [name: Mychild2]}

    #   # Starts a worker by calling: DynamicSupervxExample.Worker.start_link(arg)
    #   # {DynamicSupervxExample.Worker, arg}
    # ]

    opts = [
      name: SimpleQueue.Supervisor,
      strategy: :one_for_one
    ]


    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DynamicSupervxExample.Supervisor]
    DynamicSupervisor.start_link(opts)

{:ok, pid} = DynamicSupervisor.start_child(DynamicSupervxExample.Supervisor, Mychild2)

  end



end
