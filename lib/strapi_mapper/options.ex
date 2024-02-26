defmodule StrapiMapper.Options do
  @moduledoc """
  Options for the StrapiMapper package.

  List of options:
  - `:keys_returned_as` - The keys of the returned map will be returned as the specified type. Can be `:string` or `:atom`. Default is `:string`.
  """

  defstruct keys_returned_as: :string

  @type t :: %__MODULE__{
          keys_returned_as: :string | :atom
        }
end
