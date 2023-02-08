defmodule Numbers do
  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)

  def gcd(x, 0), do: x
  def gcd(x, y) do
    gcd(y, rem(x,y))
  end

  def primes_up_to(n) when n < 1, do: []
  def primes_up_to(n) do
    for x <- 2..n, y <- 2..(n - 1), !Enum.any?(2..n - 1), do: x
  end

  defp is_prime(n) when n <= 1, do: false
  defp is_prime(n), do: is_prime(n, 2)
  defp is_prime(n, idx) do
    if n === idx do
      true
    else
      if rem(n, idx) === 0 do
        false
      else
        is_prime(n, idx + 1)
      end
    end
  end
end
