defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1, sort_descending: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "count is defaulted if two values given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

  test "sort_descding orders issues the correct way" do
    mock_issues_list = fake_created_at_list([ "c", "d", "a", "b" ])
    sorted = sort_descending(mock_issues_list)
    ordered_issues = for issue <- sorted, do: Map.get(issue, "created_at")
    assert ordered_issues == ~w{ d c b a }
  end

  defp fake_created_at_list(values) do
    for value <- values, do: %{"created_at" => value, "other_data" => "xxx" }
  end
end
