defmodule PrimeFactors do
  def start() do
    receive do
      { sender, int } ->
        send(sender, { :ok, get_prime_factors(int) })
        start()
      _ -> raise "invalid message sent to #{self()}!"
    end
  end

  def get_prime_factors(n) do
    _prime_factor(n, [])
  end

  defp _prime_factor(n, list) when n < 2, do: list
  defp _prime_factor(n, list) do
    IO.puts "_prime_factor called with #{n} and #{inspect(list)}"
    first_factor = Enum.find(
      (2..max(2, trunc(:math.sqrt(n)))),
      nil,
      fn(f) -> rem(n, f) == 0 end
    )
    IO.puts "first_factor = #{first_factor}"
    cond do
      first_factor -> _prime_factor(div(n, first_factor), list ++ [first_factor])
      !first_factor -> list ++ [n]
    end
  end
end
