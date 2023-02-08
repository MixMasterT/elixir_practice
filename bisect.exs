defmodule Bisect do
  def guess(n, min..max) when n in min..max do
    next = get_next_guess(min, max)
    IO.puts "Is it #{next} ? (guessing over range #{inspect(min..max)})"
    if next === n do
      IO.puts "Yes, it is #{next}"
    else
      IO.puts "No, it is not #{next} :{"
      if n < next do
        guess(n, min..next)
      else
        guess(n, next..max)
      end
    end
  end

  defp get_next_guess(a, b) do
    diff = b - a
    a + div(diff, 2)
  end
end
