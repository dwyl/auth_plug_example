defmodule App.MixProject do
  use Mix.Project

  def project do
    [
      app: :app,
      version: "1.4.7",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:yecc] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test,
        c: :test
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
      {:phoenix, "~> 1.8.1"},
      {:phoenix_pubsub, "~> 2.1.1"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_html_helpers, "~> 1.0"},
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:gettext, "~> 1.0"},
      {:jason, "~> 1.4"},
      {:plug_cowboy, "~> 2.5"},

      # github.com/dwyl/auth_plug
      {:auth_plug, "~> 1.5.0"},

      #79
      {:phoenix_view, "~> 2.0"},

      # Check test coverage: https://github.com/parroty/excoveralls
      {:excoveralls, "~> 0.18.0", only: :test}
    ]
  end

  defp aliases do
    [
      c: ["coveralls.html"]
    ]
  end
end
