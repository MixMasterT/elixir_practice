defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      escript: escript_config(),
      version: "0.1.0",
      elixir: "~> 1.14.3",
      start_permanent: Mix.env() == :prod,
      name: "Github Issue Fetcher",
      deps: deps(),
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      { :httpoison, "~> 2.0" },
      { :poison, "~> 5.0.0" },
      { :ex_doc, "~> 0.29.1" },
      { :earmark, "~> 1.4.35" },
    ]
  end
  defp escript_config do
    [
      main_module: Issues.CLI
    ]
  end
end
