defmodule BlogEngine.MixProject do
  use Mix.Project

  def project do
    [
      app: :blogengine,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :eex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      { :earmark, ">= 1.4.14" },
      { :yaml_elixir, "~> 2.6" }
    ]
  end
end
