# StrapiMapper
StrapiMapper is a simple library that allows you to map Strapi responses to Elixir maps.
It doesn't care which JSON library you use, as long as you provide it with a compatible map.

## Example
```elixir
iex> StrapiMapper.map_to_struct(%{"data" => %{"id" => 1, "attributes" => %{"name" => "John"}}})
```

## Installation

Simply add `strapi_mapper` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:strapi_mapper, "~> 0.1.0"}
  ]
end
```

## Documentation
Documentation can be found at <https://hexdocs.pm/strapi_mapper>.
