defmodule Issues.CLI do

  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """

  def main(argv) do
    argv
     |> parse_args
     |> process
  end

  @doc """
  'argv' can be -h or --help, which returns :help.

  Otherwise, it is a github user name, project name, and optionally
  the number of entries to format.

  Return a tuple of `{ user, project, count }`, or `:help` if help was
  passed in.
  """

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
  end
  def process({ user, project, count }) do
    result = Issues.GithubIssues.fetch(user, project)
      |> decode_response
      |> take_last(count)
    # IO.puts result
    Issues.FormatAsTable.format_as_table(["number", "created_at", "title"], result)
  end

  def parse_args(argv) do
    parsed = OptionParser.parse(
      argv,
      switches: [ help: :boolean ],
      aliases: [ h: :help ]
    )
    _parse_arg_tuple(parsed)
  end

  def decode_response({ :ok, body }), do: body
  def decode_response({ :error, error }) do
    IO.puts "Error fetching from Github: #{error["message"]}"
    System.halt(2)
  end

  def sort_descending(list_of_issues) do
    Enum.sort(
      list_of_issues,
      fn el1, el2 -> el1["created_at"] >= el2["created_at"] end
    )
  end

  defp take_last(list, count) do
    list
      |> Enum.take(count)
      |> Enum.reverse
  end

  defp _parse_arg_tuple({ [ help: true ], _, _ }), do: :help
  defp _parse_arg_tuple({ _, [ user, project, count ], _ }) do
    { user, project, String.to_integer(count) }
  end
  defp _parse_arg_tuple({ _, [ user, project ], _ }) do
    { user, project, @default_count }
  end
  defp _parse_arg_tuple(_bad_args), do: :help
end
