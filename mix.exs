defmodule ProxyScience.Mixfile do
  use Mix.Project

  def project do
    [
      app: :proxy_science,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison, :cowboy, :plug],
      mod: {ProxyScience.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:httpoison, "~> 0.12"},
      {:poison, "~> 3.1"}
    ]
  end
end
