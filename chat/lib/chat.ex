defmodule Chat do
  @moduledoc """
  Documentation for `Chat`.
  """

  @doc """
  # iex --sname kate@localhost -S mix
  # iex(kate@localhost)1> Chat.send_message(:alex@localhost, "how are you?")

  """
  def receive_message(message) do
    IO.puts message
  end

  def send_message(:moebi@localhost, message) do
    spawn_task(__MODULE__, :receive_message_for_moebi, :moebi@localhost, [message, Node.self()])
  end

  def send_message(recipient, message) do
    spawn_task(__MODULE__, :receive_message, recipient, [message])
  end

  def receive_message_for_moebi(message, from) do
    IO.puts(message)
    send_message(from, "chicken??bark! bark!")
  end

  def spawn_task(module, fun, recipient, args) do
    recipient
    |> remote_supervisor()
    |> Task.Supervisor.async(module, fun, args)
    |> Task.await()
  end

  defp remote_supervisor(recipient) do
    # {Chat.TaskSupervisor, recipient}
    Application.get_env(:chat, :remote_supervisor).(recipient)
  end

end
