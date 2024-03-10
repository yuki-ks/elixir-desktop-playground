defmodule ElixirDesktopPlayground.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirDesktopPlaygroundWeb.Telemetry,
      {DNSCluster,
       query: Application.get_env(:elixir_desktop_playground, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ElixirDesktopPlayground.PubSub},
      # Start a worker by calling: ElixirDesktopPlayground.Worker.start_link(arg)
      # {ElixirDesktopPlayground.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirDesktopPlaygroundWeb.Endpoint,
      {Desktop.Window,
       [
         app: :elixir_desktop_playground,
         id: ElixirDesktopPlaygroundWindow,
         url: &ElixirDesktopPlaygroundWeb.Endpoint.url/0
       ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirDesktopPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirDesktopPlaygroundWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
