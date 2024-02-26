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

  ## Example
    
      iex> StrapiMapper.map_to_struct(%{"data" => %{"id" => 1, "attributes" => %{"name" => "John"}}})
      %{"id" => 1, "name" => "John"}

      iex> StrapiMapper.map_to_struct(%{"data" => %{"id" => 1, "attributes" => %{"name" => "Jane"}}}, %StrapiMapper.Options{keys_returned_as: :atoms})
      %{id: 1, name: "Jane"}

  """
  @spec map_to_struct(data :: any(), options :: StrapiMapper.Options.t()) :: map()
  def map_to_struct(data, options \\ %StrapiMapper.Options{})

  def map_to_struct(
        %{"data" => data = %{"attributes" => attributes}},
        options
      ) do
    should_keys_be_atoms? = options.keys_returned_as == :atoms
    id_key = if should_keys_be_atoms?, do: :id, else: "id"

    Enum.reduce(attributes, %{}, fn {key, value}, acc ->
      map_key = if should_keys_be_atoms?, do: String.to_atom(key), else: key
      Map.put(acc, map_key, map_to_struct(value, options))
    end)
    |> Map.put(id_key, data["id"])
  end

  def map_to_struct(%{"data" => data}, options) do
    Enum.map(data, fn datum -> map_to_struct(datum, options) end)
  end

  def map_to_struct(data = %{"attributes" => attributes}, options) do
    should_keys_be_atoms? = options.keys_returned_as == :atoms
    id_key = if should_keys_be_atoms?, do: :id, else: "id"

    Enum.reduce(attributes, %{}, fn {key, value}, acc ->
      map_key = if should_keys_be_atoms?, do: String.to_atom(key), else: key
      Map.put(acc, map_key, map_to_struct(value, options))
    end)
    |> Map.put(id_key, data["id"])
  end

  def map_to_struct(data, _options),
    do: data
end
