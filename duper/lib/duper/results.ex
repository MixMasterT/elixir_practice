defmodule Duper.Results do
  use GenServer

  @me __MODULE__

  # API
  def start_link(_) do
    GenServer.start_link(@me, :no_args, name: @me)
  end

  def add_hash_for(path, hash) do
    GenServer.cast(@me, { :add, path, hash })
  end

  def find_duplicates() do
    GenServer.call(@me, :find_duplicates)
  end

  # Server
  def init(:no_args) do
    { :ok, %{} }
  end

  def handle_cast({ :add, path, hash }, results) do
    results = Map.update(
      results,
      hash,
      [ path ],
      fn existing ->
        [ path | existing ]
      end
    )
    { :noreply, results }
  end

  def handle_call(:find_duplicates, _from, results) do
    { :reply, hashes_with_duplicates(results), results }
  end

  defp hashes_with_duplicates(results) do
    results
    |> Enum.filter(fn {_hash, path } -> length(path) > 1 end)
    |> Enum.map(&elem(&1, 1))
  end

end
