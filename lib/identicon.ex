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
    grid = build_grid(seed)
    %Identicon.Image{seed: seed, color: color}
    grid
  end

  # Hash a string with md5 algorithm and return as a list of integers.
  defp string_to_seed(string) do
    :crypto.hash(:md5, string)
    |> :erlang.binary_to_list()
  end

  # Accepts a seeded string and returns a color as {r, g, b}
  defp seed_to_color([r, g, b | _tail] = _seed) do
    [r, g, b]
  end

  defp build_grid(seed) do
    seed
    |> Enum.chunk_every(3, 3, :discard)
    |> Enum.map(&mirror_chunk/1)
    |> List.flatten()
    |> Enum.with_index()
  end

  defp mirror_chunk(chunk) do
    chunk ++ (chunk |> Enum.take(2) |> Enum.reverse())
  end
end
