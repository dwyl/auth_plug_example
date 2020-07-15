defmodule App.MixProject do
  use Mix.Project

  def project do
    [
      app: :app,
      version: "1.2.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application:
  def application do
    [
      mod: {App.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment:
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies project dependencies:
  defp deps do
    [
      {:phoenix, "~> 1.5.3"},
      {:phoenix_pubsub, "~> 2.0.0"},
      {:phoenix_html, "~> 2.14.2"},
      {:phoenix_live_reload, "~> 1.2.4", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.3.0"},

      # github.com/dwyl/auth_plug
      {:auth_plug, "~> 1.2.0"},

      # Check test coverage: https://github.com/parroty/excoveralls
      {:excoveralls, "~> 0.13.0", only: :test}
    ]
  end
end
