defmodule Stack do

  @server Stack.Server
  @moduledoc """
  Documentation for `Stack`.
  """

  @doc """
    create_stack starts a stack server with start_link
  """
  def create_stack() do
    GenServer.start_link(@server, [], name: @server)
  end

  def push(new_element) do
    GenServer.cast(@server, { :push, new_element })
  end

  def pop() do
    GenServer.call(@server, :pop)
  end
end
