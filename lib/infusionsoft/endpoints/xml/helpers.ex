defmodule Infusionsoft.Endpoints.XML.Helpers do
  @moduledoc false

  @url "https://api.infusionsoft.com/crm/xmlrpc/v1"

  @spec process_endpoint(String.t(), [any()], String.t()) :: {:ok, any()} | {:error, String.t()}
  def process_endpoint(name, params, token) do
    response =
      name
      |> method_call(params)
      |> XMLRPC.encode()
      |> case do
        {:ok, request} -> send_request(request, token)
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

  defp send_request(request, token) do
    case HTTPoison.post(@url, request, create_headers(token)) do
      {:ok, response} -> decode_body(response.body)
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  defp create_headers(token) do
    [{"Authorization", "Bearer " <> token}]
  end

  defp decode_body(body) when body == "<h1>Developer Inactive</h1>" do
    {:error, "Received the following error from Infusionsoft: Developer Inactive"}
  end

  defp decode_body(body) do
    XMLRPC.decode(body)
  end

  defp get_param_from_body(%{param: param}), do: {:ok, param}
  defp get_param_from_body(body), do: {:error, "Unexpected response: #{inspect(body)}"}
end
