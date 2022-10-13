defmodule Loki.Mixfile do
  use Mix.Project

  def project do
    [app: :loki,
     version: "1.2.2",
     elixir: "~> 1.5",
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    []
  end

  defp description do
    """
     Loki is a toolkit for building powerful command-line interfaces.
    """
  end

  defp package do
    [
      name: :loki,
      files: ~w{lib} ++
             ~w{mix.exs README.md LICENSE},
      maintainers: ["Marat Khusnetdinov"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/khusnetdinov/loki"}
    ]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end
end
