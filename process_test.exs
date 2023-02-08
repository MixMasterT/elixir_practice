defmodule ProcessTest do
  def wait_for_spawned_link() do
    spawned_pid = spawn_monitor(ProcessTest, :spawned_link, [self()])
    :timer.sleep(500)
    receive do
      { :ok, msg } -> IO.puts "the received message was #{msg}"
      any -> IO.puts "unmached result: #{inspect any}"
    end
  end

  def spawned_link(parent_pid) do
    send parent_pid, { :ok, "this message was sent from a dying child" }
    raise "donkey!"
  end

  def test_processes() do
    pid_2 = spawn(ProcessTest, :receive_and_send, ["secondly"])
    pid_1 = spawn(ProcessTest, :receive_and_send, ["firstly"])

    send(pid_1, { self(), "message one" })
    send(pid_2, { self(), "message two" })
    receive do
      { pid, msg } -> IO.puts("message recieved in parent from #{inspect(pid)}, the message was: #{msg}")
      actual_message -> IO.puts "got an invalid message in original test_processes function... -> #{inspect(actual_message)}"
    end
  end

  def receive_and_send(id_str) do
    receive do
      { caller_pid, msg_str } -> send(caller_pid, { self(), "from #{id_str}: #{msg_str}" })
      _ -> raise "Invalid message sent to #{inspect self()}"
    end
  end
end
