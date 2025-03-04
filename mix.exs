defmodule Infusionsoft.MixProject do
  use Mix.Project

  def project do
    [
      app: :infusionsoft,
      version: "0.8.1",
      elixir: "~> 1.9",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Infusionsoft",
      source_url: "https://github.com/damonvjanis/infusionsoft"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Infusionsoft.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:xmlrpc, "~> 1.0"},
      {:finch, "~> 0.5"},
      {:jason, "~> 1.0"},
      {:ex_doc, "~> 0.36", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "A wrapper for the Infusionsoft API"
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/damonvjanis/infusionsoft"}
    ]
  end
end
