defmodule Consistix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ConsistixWeb.Telemetry,
      # Start the Ecto repository
      Consistix.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Consistix.PubSub},
      # Start Finch
      {Finch, name: Consistix.Finch},
      # Start the Endpoint (http/https)
      ConsistixWeb.Endpoint
      # Start a worker by calling: Consistix.Worker.start_link(arg)
      # {Consistix.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Consistix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ConsistixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
