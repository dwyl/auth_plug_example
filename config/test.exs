use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :app, AppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :auth_plug,
  api_key:
    "2cfxNaVanCskA5bDFehsfeLL8zyekkhfiNGyAZuLJaEvwGuGwvA/2cfxNa2yvEDA5tHudHR9AMGvzzzZ1j4Y1MXQ7jTQzzAawdxxyfU/authdev.herokuapp.com",
  httpoison_mock: true