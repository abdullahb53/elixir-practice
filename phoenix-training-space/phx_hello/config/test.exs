import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phx_hello, PhxHelloWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "vAIFQV93CwevRRXPo6y3+zGMSOhIrSQGDt6O68g2zNLkefrH8eIFbVYXi2jA9KLQ",
  server: false

# In test we don't send emails.
config :phx_hello, PhxHello.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
