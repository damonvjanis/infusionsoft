defmodule Infusionsoft.MixProject do
  use Mix.Project

  def project do
    [
      app: :infusionsoft,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Infusionsoft.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:xmlrpc, "~> 1.0"},
      {:httpoison, "~> 1.4"}
    ]
  end
end
