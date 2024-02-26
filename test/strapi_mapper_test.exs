defmodule StrapiMapperTest do
  use ExUnit.Case
  doctest StrapiMapper

  test "maps a primitive value" do
    assert StrapiMapper.map_to_struct(1) == 1
  end

  test "maps a singular strapi response" do
    response = %{
      "data" => %{
        "id" => 1,
        "attributes" => %{
          "name" => "John Doe",
          "email" => "jd@test.com"
        }
      }
    }

    assert StrapiMapper.map_to_struct(response) == %{
             "id" => 1,
             "name" => "John Doe",
             "email" => "jd@test.com"
           }
  end

  test "maps a collection of strapi responses" do
    response = %{
      "data" => [
        %{
          "id" => 1,
          "attributes" => %{
            "name" => "John Doe",
            "email" => "jd@test.com"
          }
        },
        %{
          "id" => 2,
          "attributes" => %{
            "name" => "Jane Doe",
            "email" => "janed@test.com"
          }
        }
      ]
    }

    assert StrapiMapper.map_to_struct(response) == [
             %{
               "id" => 1,
               "name" => "John Doe",
               "email" => "jd@test.com"
             },
             %{
               "id" => 2,
               "name" => "Jane Doe",
               "email" => "janed@test.com"
             }
           ]
  end

  test "maps a nested strapi response" do
    response = %{
      "data" => %{
        "id" => 1,
        "attributes" => %{
          "name" => "John Doe",
          "spouse" => %{
            "id" => 2,
            "attributes" => %{
              "name" => "John Doe",
              "email" => "janed@test.com"
            }
          }
        }
      }
    }

    assert StrapiMapper.map_to_struct(response) == %{
             "id" => 1,
             "name" => "John Doe",
             "spouse" => %{
               "id" => 2,
               "name" => "John Doe",
               "email" => "janed@test.com"
             }
           }
  end
end
