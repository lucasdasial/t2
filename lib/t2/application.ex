defmodule T2.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      T2Web.Telemetry,
      T2.Repo,
      {DNSCluster, query: Application.get_env(:t2, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: T2.PubSub},
      # Start a worker by calling: T2.Worker.start_link(arg)
      # {T2.Worker, arg},
      # Start to serve requests, typically the last entry
      T2Web.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: T2.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    T2Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
