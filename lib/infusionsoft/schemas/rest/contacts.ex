defmodule Infusionsoft.Schemas.REST.Contacts do
  @moduledoc """
  Contains functions to translate between common names and REST api names for Contacts.
  """

  import String, only: [downcase: 1]
  import Infusionsoft.Schemas.Contacts, only: [common_to_rest_downcase: 0, rest_to_common: 0]

  @common_to_rest_downcase common_to_rest_downcase()
  @rest_to_common rest_to_common()

  @doc "Takes a list of Common names and returns REST names"
  @spec to([String.t()], String.t()) :: {:ok, list()} | {:error, String.t()}
  def to(names, token) when is_list(names) do
    results = Enum.map(names, &get_name(&1, @common_to_rest_downcase, token, downcase: true))

    if !Enum.any?(results, fn {status, _} -> status == :error end) do
      {:ok, Enum.map(results, fn {_, name} -> name end)}
    else
      {:error,
       results
       |> Enum.filter(fn {status, _} -> status == :error end)
       |> Enum.map(fn {_, message} -> message end)
       |> Enum.join(", ")}
    end
  end

  @doc "Takes a list of REST names and returns Common names"
  @spec from([String.t()], String.t()) :: {:ok, list()} | {:error, String.t()}
  def from(names, token) when is_list(names) do
    results = Enum.map(names, &get_name(&1, @rest_to_common, token))

    if !Enum.any?(results, fn {status, _} -> status == :error end) do
      {:ok, Enum.map(results, fn {_, name} -> name end)}
    else
      {:error,
       results
       |> Enum.filter(fn {status, _} -> status == :error end)
       |> Enum.map(fn {_, message} -> message end)
       |> Enum.join(", ")}
    end
  end

  defp get_name(name, map, token, opts \\ []) do
    opts = Keyword.merge([downcase: false], opts)
    value = if(Keyword.get(opts, :downcase), do: map[downcase(name)], else: map[name])

    if value do
      {:ok, value}
    else
      query = %{}
      # Infusionsoft.XML.DataService.query(token, "DataFormField", query, return_fields)
      {:error, ~s[The name "#{name}" is not a standard or custom contact field]}
    end
  end
end
