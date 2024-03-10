defmodule ElixirDesktopPlayground.Repo do
  use Ecto.Repo,
    otp_app: :elixir_desktop_playground,
    adapter: Ecto.Adapters.SQLite3
end
