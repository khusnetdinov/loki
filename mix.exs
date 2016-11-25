defmodule Loki.Mixfile do
  use Mix.Project

  def project do
    [app: :loki,
     version: "0.1.0",
     elixir: "~> 1.3",
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    []
  end

  defp description do
    """
    Description
    """
  end

  defp package do
    [
      name: :loki,
      files: [],
      maintainers: [],
      licenses: [],
      links: []
    ]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end
end
