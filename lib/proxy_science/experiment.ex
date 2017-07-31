defmodule ProxyScience.Experiment do
  require Logger

  def run(%{truth: truth, experiement: experiement}, method) do
    result = make_request(method, truth)
    Task.start(fn -> run_experiment(result, method, experiement) end)
    result
  end

  def run_experiment(%{status_code: status, body: body}, method, experiment) do
    %{status_code: e_status, body: e_body} = make_request(method, experiment)

    if status == e_status && body == e_body do
      Logger.info("experiment was success")
    else
      Logger.warn("experiment was broken")
    end
  end

  defp make_request(method, url) do
    {:ok, result} = apply(HTTPoison, method(method), [url])
    result
  end

  defp method(method) do
    method
    |> String.downcase
    |> String.to_atom
  end
end
