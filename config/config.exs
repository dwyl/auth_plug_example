# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :app, AppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Eu8e8Anoh4Cnebh0gA+ZKsOwNz8WozQSILdGsxCjre9WjiQ4z8BXtH/VFBTCzMSD",
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json)],
  # pubsub: [name: App.PubSub, adapter: Phoenix.PubSub.PG2],
  pubsub_server: App.PubSub,
  live_view: [signing_salt: "mgRO+JX0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :auth_plug,
  api_key: System.get_env("AUTH_API_KEY")
