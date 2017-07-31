defmodule ProxyScience.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  @experiements [
    %{ url: "/search", truth: "http://google.com", experiement: "http://google.com" }
  ]

  match _ do
    if experiment = find_experiment(conn) do
      %{status_code: status_code, body: body} = ProxyScience.Experiment.run(experiment, conn.method)
      send_resp(conn, status_code, body)
    else
      send_resp(conn, 404, Poison.encode(%{error: "not found"}))
    end
  end

  defp find_experiment(conn) do
    Enum.find(@experiements, fn route -> route.url == conn.request_path end)
  end
end
