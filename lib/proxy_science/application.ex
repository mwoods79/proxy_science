defmodule ProxyScience.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: ProxyScience.Worker.start_link(arg)
      # {ProxyScience.Worker, arg},
      Plug.Adapters.Cowboy.child_spec(:http, ProxyScience.Router, [], [port: 4001])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProxyScience.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
