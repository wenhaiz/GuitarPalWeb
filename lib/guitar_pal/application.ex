defmodule GuitarPal.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GuitarPalWeb.Telemetry,
      GuitarPal.Repo,
      {DNSCluster, query: Application.get_env(:guitar_pal, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GuitarPal.PubSub},
      # Start a worker by calling: GuitarPal.Worker.start_link(arg)
      # {GuitarPal.Worker, arg},
      # Start to serve requests, typically the last entry
      GuitarPalWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GuitarPal.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GuitarPalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
