use Mix.Config

config :bugsnag_elixir,
  api_token: System.get_env("BUGSNAG_API_TOKEN"),
  release_stage: 'dev',
  auto_notify: true,
  use_ssl: true
