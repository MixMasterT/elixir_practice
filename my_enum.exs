defmodule MyEnum do
  def all?([], _func), do: true
  def all?([ head | tail ], func) do
    if !func.(head) do
      false
    else
      all?(tail, func)
    end
  end

  def each([], _func), do: :ok
  def each([ head | tail ], func) do
    func.(head)
    each(tail, func)
  end

  def split(l1 \\ [], _l2, _count)
  def split(l1, l2, 0), do: {Enum.reverse(l1), l2}
  def split(_, _, count) when count < 0 do
    raise "The third 'count' argument for MyEnum.split can not be a negative number!"
  end
  def split(l1, [], _count) do
    {Enum.reverse(l1), []}
  end
  def split(l1, [ head | tail ], count) do
    split([ head | l1 ], tail, count - 1)
  end

  def take([], _n), do: []
  def take(_list, 0), do: []
  def take([ head | tail ], n) do
    take(tail, abs(n) - 1, [head])
  end
  def take(_list, 0, result) do
    Enum.reverse(result)
  end
  def take([], _n, result) do
    Enum.reverse(result)
  end
  def take([head | tail], n, result) do
    take(tail, abs(n) - 1, [head | result])
  end

  def flatten([]), do: []
  def flatten([ h | [] ]) do
    if is_list(h) do
      flatten(h)
    else
      [h]
    end
  end
  def flatten([ h | t ]) do
    if is_list(h) do
      flatten(h) ++ flatten(t)
    else
      [ h | flatten(t) ]
    end
  end
end
