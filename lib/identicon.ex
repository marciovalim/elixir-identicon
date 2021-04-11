defmodule Identicon do
  @moduledoc """
  Creates an identicon given a string input.
  """

  @doc """
  Create an identicon a string as `input`.

  ## Examples

      iex> Identicon.create()
      :world

  """
  def create(string) do
    seed = string_to_seed(string)
    color = seed_to_color(seed)

    get_colored_squares(seed)
    |> get_positions_map()
    |> draw_image(color)
    |> save_image(string)
  end

  # Hash a string with md5 algorithm and return as a list of integers.
  defp string_to_seed(string) do
    :crypto.hash(:md5, string)
    |> :erlang.binary_to_list()
  end

  # Accepts a seeded string and returns a color as {r, g, b}
  defp seed_to_color([r, g, b | _tail] = _seed) do
    {r, g, b}
  end

  defp get_colored_squares(seed) do
    seed
    |> Enum.chunk_every(3, 3, :discard)
    |> Enum.map(&mirror_chunk/1)
    |> List.flatten()
    |> Enum.with_index()
    |> removeOddSquares()
  end

  defp mirror_chunk(chunk) do
    chunk ++ (chunk |> Enum.take(2) |> Enum.reverse())
  end

  defp removeOddSquares(grid) do
    Enum.filter(grid, fn {cellCode, _index} ->
      rem(cellCode, 2) == 0
    end)
  end

  defp get_positions_map(colored_squares) do
    Enum.map(colored_squares, fn {_code, index} ->
      x = rem(index, 5) * 50
      y = div(index, 5) * 50
      top_left = {x, y}
      bottom_right = {x + 50, y + 50}

      {top_left, bottom_right}
    end)
  end

  defp draw_image(positions, color) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(positions, fn {top_left, bottom_right} ->
      :egd.filledRectangle(image, top_left, bottom_right, fill)
    end)

    :egd.render(image)
  end

  defp save_image(image_file, filename) do
    File.write("outputs/#{filename}.png", image_file)
  end
end
