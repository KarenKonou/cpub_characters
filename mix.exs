defmodule CommonsPub.Characters.MixProject do
  use Mix.Project

  def project do
    [
      app: :cpub_characters,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: "Character-related models for commonspub",
      homepage_url: "https://github.com/commonspub/cpub_characters",
      source_url: "https://github.com/commonspub/cpub_characters",
      package: [
        licenses: ["MPL 2.0"],
        links: %{
          "Repository" => "https://github.com/commonspub/cpub_characters",
          "Hexdocs" => "https://hexdocs.pm/cpub_characters",
        },
      ],
      docs: [
        main: "readme", # The first page to display from the docs 
        extras: ["README.md"], # extra pages to include
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:pointers, "~> 0.5.1"},
      # {:pointers, git: "https://github.com/commonspub/pointers", branch: "main"},
      # {:pointers, path: "../pointers", override: true},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
    ]
  end
end
