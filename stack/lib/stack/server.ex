defmodule Stack.Server do
  use GenServer

  def init(initial_content) do
    { :ok, initial_content }
  end

  def handle_call(:pop, _from, current_content) do
    [ first_el | rest ] = current_content
    { :reply, first_el, rest }
  end

  def handle_cast({ :push, new_item }, current_content) do
    { :noreply,[new_item | current_content]}
  end

end
