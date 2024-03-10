import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :elixir_desktop_playground, ElixirDesktopPlayground.Repo,
  database: Path.expand("../elixir_desktop_playground_test.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixir_desktop_playground, ElixirDesktopPlaygroundWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "gjzTfW6kq2lJof4epgqdmaoOhSzex+xx+rG0qLfYk7VdqGZf2MqtT3JQ6a/YJVmM",
  server: false

# In test we don't send emails.
config :elixir_desktop_playground, ElixirDesktopPlayground.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
