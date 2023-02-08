defmodule MyList do
  def map([], _func), do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

  def reduce([], value, _func), do: value
  def reduce([ head | tail ], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def mapsum([], _func), do: 0
  def mapsum([ head | tail ], func) do
    func.(head) + mapsum(tail, func)
  end

  def max([ head | []]), do: head
  def max([ head | tail ]) do
    tail_max = max(tail)
    if (head > tail_max) do
      head
    else
      tail_max
    end
  end

  def caesar([], _offset), do: []
  def caesar([ head | tail ], offset) do
    if head + offset > ?z do
      [ ?a + head + offset  - (?z + 1) | caesar(tail, offset) ]
    else
      [ head + offset | caesar(tail, offset) ]
    end
  end

  def span(to, to), do: [to] # include the to number in the final result
  def span(from, to) do
    if from > to do
      raise "span can only be called with from < to, but it was called with from=#{from} and to=#{to}"
    else
      [from | span(from + 1, to) ]
    end
  end
end
