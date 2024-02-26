defmodule StrapiMapper.MixProject do
  use Mix.Project

  def project do
    [
      app: :strapi_mapper,
      version: "0.1.0",
      description:
        "StrapiMapper is a simple Elixir library used to map Strapi responses to Elixir maps.",
      elixir: "~> 1.16",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      source_url: "https://github.com/zvonimirr/strapi_mapper",
      links: %{
        "GitHub" => "https://github.com/zvonimirr/strapi_mapper"
      }
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end
end
