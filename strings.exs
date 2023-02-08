defmodule Strings do
  def all_printable?([]), do: true
  def all_printable?([ head | tail ]) do
    if (head <= ?~) and (head >= ?\s) do
      all_printable?(tail)
    else
      false
    end
  end

  def anagram?(w1, w2) when is_list(w1) and is_list(w2) do
    Enum.sort(w1) === Enum.sort(w2)
  end
  def anagram?(w1, w2) when is_binary(w1) or is_binary(w2) do
    if is_binary(w1) and is_binary(w2) do
      anagram?(String.to_charlist(w1), String.to_charlist(w2))
    else
      if is_binary(w1) do
        anagram?(String.to_charlist(w1), w2)
      else
        anagram?(w1, String.to_charlist(w2))
      end
    end
  end

  def parse_op(char_list) do
    str = to_string(char_list)
    [arg1, op, arg2] = String.split(str)
    calc(parse_n(arg1), Enum.at(to_charlist(op), 0), parse_n(arg2))
  end

  defp calc(x, op, y) when op === 43, do: x + y
  defp calc(x, op, y) when op === 45, do: x - y
  defp calc(x, op, y) when op === 42, do: x * y
  defp calc(x, op, y) when op === 47, do: x / y

  def parse_n(""), do: 0
  def parse_n(n_str) do
    len = String.length(n_str)
    [first | rest] = to_charlist(n_str)
    10 ** len * (first - 48) + parse_n(to_string(rest))
  end

  def align_center(list_of_strings) do
    longest = Enum.max_by(list_of_strings, &(String.length(&1)))
    longest_length = String.length(longest)
    Enum.each list_of_strings, &(print_with_padding(&1, longest_length))
  end

  defp print_with_padding(str, target_length) do
    if String.length(str) < target_length do
      print_with_padding(" " <> str <> " ", target_length)
    else
      IO.puts(str)
    end
  end

  def capitalize_sentences(str, is_first_call \\ true)
  def capitalize_sentences(<<>>, _), do: ""
  def capitalize_sentences(str, true), do: capitalize_next_letter(str)
  def capitalize_sentences(<< head :: utf8, tail :: binary >>, false) do
    if <<head>> === "." do
      <<head>> <> capitalize_next_letter(tail)
    else
      String.downcase(<<head>>) <> capitalize_sentences(tail, false)
    end
  end


  defp capitalize_next_letter(<<>>), do: ""
  defp capitalize_next_letter(<< head :: utf8, tail :: binary >>) do
    if String.match?(<<head>>, ~r/[a-z]/) do
      String.upcase(<<head>>) <> capitalize_sentences(tail, false)
    else
      <<head>> <> capitalize_next_letter(tail)
    end
  end
end
