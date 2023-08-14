defmodule Scraper.MixProject do
  use Mix.Project

  def project do
    [
      app: :scraper,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Scraper, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:plug_cowboy, "~> 2.0"},
      {:meeseeks, "~> 0.17.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
    ]
  end

  defp elixirc_paths(:test) do
    ["lib", "test/scraper"]
  end
  defp elixirc_paths(_) do
    ["lib"]
  end
end
