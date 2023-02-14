defmodule Profiler do
  @moduledoc """
  Documentation for `Profiler`.
  """
  use Application

  @impl true
  def start(_type, _args) do
    Profiler.Supervisor.start_link(name: Profiler.Supervisor)
  end

end
