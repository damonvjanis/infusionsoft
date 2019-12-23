defmodule Infusionsoft.Endpoints.REST.Helpers do
  @moduledoc false

  @url "https://api.infusionsoft.com/crm/rest/v1"
  @accept_json {"Accept", "application/json"}
  @accept_all {"Accept", "*/*"}
  @content_json {"Content-Type", "application/json"}

  @spec process_endpoint(String.t(), atom(), String.t(), String.t() | nil) ::
          {:ok, any()} | {:error, any()}
  def process_endpoint(path, method, token, body \\ nil) do
    headers = build_headers(token)
    send_request("#{@url}/#{path}", method, body, headers)
  end

  defp send_request(url, :get, nil, headers) do
    case HTTPoison.get(url, headers) do
      {:ok, response} -> decode_body(response.body)
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  defp send_request(url, :patch, body, headers) do
    case HTTPoison.patch(url, body, headers) do
      {:ok, response} -> decode_body(response.body)
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  defp send_request(_url, :get, body, _headers) do
    {:error, "Body not needed in GET request: #{body}"}
  end

  defp send_request(_url, method, _body, _headers) do
    {:error, "#{method |> to_string() |> String.upcase()} method not implemented"}
  end

  defp build_headers(token), do: [@accept_json, @accept_all, auth(token), @content_json]

  defp auth(token), do: {"Authorization", "Bearer #{token}"}

  defp decode_body(body) when body == "<h1>Developer Inactive</h1>" do
    {:error, "Received the following error from Infusionsoft: Developer Inactive"}
  end

  defp decode_body(body) do
    Jason.decode(body)
  end

  def build_params(nil), do: ""
  def build_params(params) when params == %{}, do: ""

  def build_params(params) when is_map(params) do
    "?" <> (params |> Enum.map(fn {k, v} -> "#{k}=#{v}" end) |> Enum.join("&"))
  end
end
