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
  def create(input) do
    input
    |> hash_input()
  end

  # Hash a string with md5 algorithm and return as a list of integers.
  defp hash_input(input) do
    :crypto.hash(:md5, input)
    |> :erlang.binary_to_list()
  end
end
