defmodule Infusionsoft.Schemas.XML.Contacts do
  @moduledoc """
  Contains functions to translate between common names and XML api names for Contacts.
  """

  import String, only: [downcase: 1]
  import Infusionsoft.Schemas.Contacts, only: [common_to_xml_downcase: 0, xml_to_common: 0]

  alias Infusionsoft.Caches.ContactCustomFields

  @common_to_xml_downcase common_to_xml_downcase()
  @xml_to_common xml_to_common()

  @doc "Takes a list of Common names and returns XML names or list of errors"
  @spec to([String.t()], String.t(), nil | String.t()) :: {:ok, list()} | {:error, String.t()}
  def to(names, token, app) when is_list(names) do
    results = Enum.map(names, &get_name(&1, @common_to_xml_downcase, token, app, downcase: true))

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

  @doc "Takes a list of XML names and returns Common names or list of errors"
  @spec from([String.t()], String.t(), nil | String.t()) :: {:ok, list()} | {:error, String.t()}
  def from(names, token, app) when is_list(names) do
    results = Enum.map(names, &get_name(&1, @xml_to_common, token, app))

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

  defp get_name(name, map, token, app, opts \\ []) do
    # If our map has downcase keys we need to transform before accessing the map.
    opts = Keyword.merge([downcase: false], opts)
    value = if(Keyword.get(opts, :downcase), do: map[downcase(name)], else: map[name])

    if value do
      {:ok, value}
    else
      if String.first(name) == "_" do
        get_custom_field_from(name, token, app)
      else
        get_custom_field_to(name, token, app)
      end
    end
  end

  defp get_custom_field_to(name, token, app) do
    with {:ok, field} <- ContactCustomFields.lookup(ContactCustomFields, name, token, app) do
      {:ok, "_" <> field["Name"]}
    end
  end

  defp get_custom_field_from(name, token, app) do
    with {:ok, field} <- ContactCustomFields.lookup(ContactCustomFields, name, token, app) do
      {:ok, field["Label"]}
    end
  end
end
