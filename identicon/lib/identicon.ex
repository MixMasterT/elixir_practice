defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  @doc """
  main is the only public method and it creates an identicon image (.png)
  from the passed-in string. The png file's name will match the string.
  """
  def main(input_string) do
    input_string
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input_string)
  end

  defp hash_input(string) do
    hex_list = :crypto.hash(:md5, string)
    |> :binary.bin_to_list

    %Identicon.Image{ hex: hex_list }
  end

  defp pick_color(%Identicon.Image{ hex: [r, g, b | _tail] } = image) do
    %Identicon.Image{ image | color: { r, g, b }}
  end

  defp build_grid(%Identicon.Image{ hex: hex } = image) do
    grid = hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{ image | grid: grid }
  end

  defp mirror_row(row) do
    [first, second | _rest] = row
    row ++ [second, first]
  end

  defp filter_odd_squares(%Identicon.Image{ grid: grid } = image) do
    grid = Enum.filter grid, fn({ code, _index }) ->
      rem(code, 2) == 0
    end
    %Identicon.Image{ image | grid: grid }
  end

  defp build_pixel_map(%Identicon.Image{ grid: grid } = image) do
    pixel_map = Enum.map grid, fn({ _code, index }) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = { horizontal, vertical }
      bottom_right = { horizontal + 50, vertical + 50 }

      { top_left, bottom_right }
    end

    %Identicon.Image{ image | pixel_map: pixel_map }
  end

  defp draw_image(%Identicon.Image{ color: color, pixel_map: pixel_map }) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({ start, stop }) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  defp save_image(image, filename) do
    File.write("#{filename}.png", image)
  end
end
