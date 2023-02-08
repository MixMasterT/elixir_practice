defmodule FormatAsTableTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import String, only: [ pad_trailing: 2 ]

  alias Issues.FormatAsTable, as: TF

  @simple_test_data [
    [ c1: "r1 c1", c2: "r1 c2", c3: "r1 c3", c4: "r1+++c4" ],
    [ c1: "r2 c1", c2: "r2 c2", c3: "r2 c3", c4: "r2 c4" ],
    [ c1: "r3 c1", c2: "r3 c2", c3: "r3 c3", c4: "r3 c4" ],
    [ c1: "r4 c1", c2: "r4++c2", c3: "r4 c3", c4: "r4 c4" ]
  ]
  @headers [ :c1, :c2, :c4 ]

  def split_with_three_columns do
    TF.split_into_columns(@headers, @simple_test_data)
  end

  test "split_into_columns" do
    columns = split_with_three_columns()
    assert length(columns) == length(@headers)
    assert List.first(columns) == ["r1 c1", "r2 c1", "r3 c1", "r4 c1"]
    assert List.last(columns) == ["r1+++c4", "r2 c4", "r3 c4", "r4 c4"]
  end

  test "column_widths" do
    widths = TF.widths_of(split_with_three_columns())
    assert widths == [ 5, 6, 7 ]
  end

  test "correct format string returned" do
    assert TF.format_for([9, 10, 11]) == "~-9s | ~-10s | ~-11s~n"
  end

  test "Output is correct" do
    result = capture_io fn ->
      TF.format_as_table(@headers, @simple_test_data)
    end
    IO.puts "the result is: "
    IO.puts result
    assert result == """
    c1    | c2     | #{pad_trailing("c4", 7)}
    ------+--------+--------
    r1 c1 | r1 c2  | r1+++c4
    r2 c1 | r2 c2  | r2 #{pad_trailing("c4", 4)}
    r3 c1 | r3 c2  | r3 #{pad_trailing("c4", 4)}
    r4 c1 | r4++c2 | r4 #{pad_trailing("c4", 4)}
    """
  end
end
