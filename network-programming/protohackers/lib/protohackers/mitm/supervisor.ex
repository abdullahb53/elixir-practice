defmodule Protohackers.Mitm.Supervisor do
  use Supervisor

  def start_link([] = _opts) do
    Supervisor.start_link(__MODULE__, :no_args)
  end

  @impl true
  def init(:no_args) do
    children = []
    Supervisor.init(children, strategy: :one_for_one)
  end


end
