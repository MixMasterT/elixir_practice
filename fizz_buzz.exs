defmodule FizzBuzz do
  def fizz_buzz(n) do
    Enum.map(
      1..n,
      &(fizz_buzz_single_output(rem(&1, 5), rem(&1, 3), &1))
    )
  end

  defp fizz_buzz_single_output(mod5, mod3, n) do
    case { mod5, mod3 } do
      { 0, 0 } -> "FizzBuzz"
      { 0, _ } -> "Fizz"
      { _, 0 } -> "Buzz"
      { _, _ } -> n
    end
  end
end


# fizz_buzz = fn
#     0, 0, _ -> "FizzBuzz"
#     0, _, _ -> "Fizz"
#     _, 0, _ -> "Buzz"
#     _, _, third -> third
# end

# run_fizz_buzz = fn (n) ->
#     fizz_buzz.(rem(n,5), rem(n, 3), n)
# end

# IO.puts run_fizz_buzz.(10)
# IO.puts run_fizz_buzz.(11)
# IO.puts run_fizz_buzz.(12)
# IO.puts run_fizz_buzz.(13)
# IO.puts run_fizz_buzz.(14)
# IO.puts run_fizz_buzz.(15)
