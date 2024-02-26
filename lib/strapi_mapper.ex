defmodule StrapiMapper do
  @moduledoc """
  StrapiMapper is a library for mapping Strapi responses to Elixir maps.
  It doesn't care which JSON library you use, it just needs a map as input.
  """

  @doc """
  Maps a Strapi response map to a normalized Elixir map.

  If the input data is a list, it will map each element of the list.

  If the input data is a map, it will map each key-value pair of the map.

  Otherwise, it will return the input data.
  """
  def map_to_struct(%{"data" => data = %{"attributes" => attributes}}) do
    Enum.reduce(attributes, %{}, fn {key, value}, acc ->
      Map.put(acc, key, map_to_struct(value))
    end)
    |> Map.put("id", data["id"])
  end

  def map_to_struct(%{"data" => data}) do
    Enum.map(data, &map_to_struct/1)
  end

  def map_to_struct(data = %{"attributes" => attributes}) do
    Enum.reduce(attributes, %{}, fn {key, value}, acc ->
      Map.put(acc, key, map_to_struct(value))
    end)
    |> Map.put("id", data["id"])
  end

  def map_to_struct(data), do: data
end
