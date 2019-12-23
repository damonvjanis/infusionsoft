defmodule Infusionsoft.Endpoints.XML.Helpers do
  @moduledoc false

  @url "https://api.infusionsoft.com/crm/xmlrpc/v1"

  @spec process_endpoint(String.t(), [any()], String.t(), nil | String.t()) ::
          {:ok, any()} | {:error, String.t()}
  def process_endpoint(name, params, token, app) do
    response =
      name
      |> method_call(params)
      |> XMLRPC.encode()
      |> case do
        {:ok, request} -> send_request(request, token, app)
        {:error, error} -> {:error, error}
      end

    case response do
      {:ok, body} -> get_param_from_body(body)
      {:error, error} -> {:error, error}
    end
  end

  defp method_call(name, params) do
    %XMLRPC.MethodCall{method_name: name, params: params}
  end

  defp send_request(request, token, nil) do
    case Mojito.post(@url, build_headers(token), request) do
      {:ok, response} -> decode_body(response.body)
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  defp send_request(request, _token, app) do
    case Mojito.post("https://#{app}.infusionsoft.com/api/xmlrpc", [], request) do
      {:ok, response} -> decode_body(response.body)
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  defp build_headers(token), do: [{"Authorization", "Bearer " <> token}]

  defp decode_body(body) when body == "<h1>Developer Inactive</h1>" do
    {:error, "Received the following error from Infusionsoft: Developer Inactive"}
  end

  defp decode_body(body) do
    XMLRPC.decode(body)
  end

  defp get_param_from_body(%{param: param}), do: {:ok, param}
  defp get_param_from_body(body), do: {:error, "Unexpected response: #{inspect(body)}"}

  @spec build_params(list() | nil, String.t(), nil | String.t()) :: list()
  def build_params(params, token, app)
  def build_params(nil, _token, nil), do: [""]
  def build_params(params, _token, nil), do: ["" | params]
  def build_params(nil, token, _app), do: [token]
  def build_params(params, token, _app), do: [token | params]
end
