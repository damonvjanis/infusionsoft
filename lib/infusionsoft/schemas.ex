defmodule Infusionsoft.Schemas do
  @moduledoc false

  # Provides functions for transforming field names.
  #
  # The "to" functions take lists of Common names and turn them into REST or XML names.
  #
  # The "from" functions take lists of REST or XML names and turn them into Common names.

  alias Infusionsoft.Schemas.REST
  alias Infusionsoft.Schemas.XML

  @doc """
  Takes a list of Common names and returns REST names.

  Names that aren't in the standard set of Common names will be treated as custom field names.

  Names that don't match anything trigger an error showing all the names that didn't match.

  Inputs are not case sensitive, but be careful to include any spaces.
  For example, "fIrSt NaMe" is fine but "Firstname" would fail.

  ## Examples

      iex> Infusionsoft.Schemas.to_rest(["First Name"], "test_token", :contacts)
      {:ok, ["given_name"]}

      iex> Infusionsoft.Schemas.to_rest(["lAsT nAmE"], "test_token", :contacts)
      {:ok, ["family_name"]}

      iex> Infusionsoft.Schemas.to_rest(["Last Name"], "test_token", :not_a_valid_type)
      {:error, "The type \\"not_a_valid_type\\" is invalid"}

      iex> Infusionsoft.Schemas.to_rest(["Not a valid name"], "test_token", :contacts)
      {:error, "The name \\"Not a valid name\\" is not a standard or custom contact field"}
  """
  @spec to_rest([String.t()], String.t(), atom()) :: {:ok, list()} | {:error, String.t()}
  def to_rest(names, token, :contacts) when is_list(names), do: REST.Contacts.to(names, token)

  def to_rest(names, _token, type) when is_list(names),
    do: {:error, ~s(The type "#{type}" is invalid)}

  @doc """
  Takes a map of key / value pairs with REST name keys and returns the map with Common name keys.

  Names that aren't in the standard set of REST names will be treated as custom field names.

  Names that don't match anything trigger an error showing all the names that didn't match.
  """
  @spec keys_to_rest(map(), String.t(), :contacts) :: {:ok, map()} | {:error, binary()}
  def keys_to_rest(map, token, :contacts) do
    pairs = Enum.map(map, fn {k, v} -> {to_rest([k], token, :contacts), v} end)

    case Enum.filter(pairs, fn {{status, _}, _} -> status == :error end) do
      [] ->
        {:ok, Enum.into(pairs, %{}, fn {{_, [k]}, v} -> {k, v} end)}

      errors ->
        {:error, errors |> Enum.map(fn {{_, message}, _} -> message end) |> Enum.join(", ")}
    end
  end

  @doc """
  Takes a list of REST names and returns Common names.

  Names that aren't in the standard set of REST names will be treated as custom field names.

  Names that don't match anything trigger an error showing all the names that didn't match.

  ## Examples

      iex> Infusionsoft.Schemas.from_rest(["given_name"], "test_token", :contacts)
      {:ok, ["First Name"]}

      iex> Infusionsoft.Schemas.from_rest(["family_name"], "test_token", :not_a_valid_type)
      {:error, "The type \\"not_a_valid_type\\" is invalid"}

      iex> Infusionsoft.Schemas.from_rest(["Not a valid name"], "test_token", :contacts)
      {:error, "The name \\"Not a valid name\\" is not a standard or custom contact field"}
  """
  @spec from_rest([String.t()], String.t(), atom()) :: {:ok, list()} | {:error, String.t()}
  def from_rest(names, token, :contacts) when is_list(names), do: REST.Contacts.from(names, token)

  def from_rest(names, _token, type) when is_list(names),
    do: {:error, ~s(The type "#{type}" is invalid)}

  @doc """
  Takes a map of key / value pairs with Common name keys and returns the map with REST name keys.

  Names that aren't in the standard set of Common names will be treated as custom field names.

  Names that don't match anything trigger an error showing all the names that didn't match.
  """
  @spec keys_from_rest(map(), String.t(), :contacts) :: {:ok, map()} | {:error, binary()}
  def keys_from_rest(map, token, :contacts) do
    pairs = Enum.map(map, fn {k, v} -> {from_rest([k], token, :contacts), v} end)

    case Enum.filter(pairs, fn {{status, _}, _} -> status == :error end) do
      [] ->
        {:ok, Enum.into(pairs, %{}, fn {{_, [k]}, v} -> {k, v} end)}

      errors ->
        {:error, errors |> Enum.map(fn {{_, message}, _} -> message end) |> Enum.join(", ")}
    end
  end

  @doc """
  Takes a list of Common names and returns XML names.

  Names that aren't in the standard set of Common names will be treated as custom field names.

  Names that don't match anything trigger an error showing all the names that didn't match.

  Inputs are not case sensitive, but be careful to include any spaces.
  For example, "fIrSt NaMe" is fine but "Firstname" would fail.

  ## Examples

      iex> Infusionsoft.Schemas.to_xml(["First Name"], "test_token", :contacts)
      {:ok, ["FirstName"]}

      iex> Infusionsoft.Schemas.to_xml(["lAsT nAmE"], "test_token", :contacts)
      {:ok, ["LastName"]}

      iex> Infusionsoft.Schemas.to_xml(["Last Name"], "test_token", :not_a_valid_type)
      {:error, "The type \\"not_a_valid_type\\" is invalid"}

      iex> Infusionsoft.Schemas.to_xml(["Not a valid name"], "test_token", :contacts)
      {:error, "The name \\"Not a valid name\\" is not a standard or custom contact field"}
  """
  @spec to_xml([String.t()], String.t(), atom()) :: {:ok, list()} | {:error, String.t()}
  def to_xml(names, token, :contacts) when is_list(names), do: XML.Contacts.to(names, token)

  def to_xml(names, _token, type) when is_list(names),
    do: {:error, ~s(The type "#{type}" is invalid)}

  @doc """
  Takes a map of key / value pairs with XML name keys and returns the map with Common name keys.

  Names that aren't in the standard set of XML names will be treated as custom field names.

  Names that don't match anything trigger an error showing all the names that didn't match.
  """
  @spec keys_to_xml(map(), String.t(), :contacts) :: {:ok, map()} | {:error, binary()}
  def keys_to_xml(map, token, :contacts) do
    pairs = Enum.map(map, fn {k, v} -> {to_xml([k], token, :contacts), v} end)

    case Enum.filter(pairs, fn {{status, _}, _} -> status == :error end) do
      [] ->
        {:ok, Enum.into(pairs, %{}, fn {{_, [k]}, v} -> {k, v} end)}

      errors ->
        {:error, errors |> Enum.map(fn {{_, message}, _} -> message end) |> Enum.join(", ")}
    end
  end

  @doc """
  Takes a list of XML names and returns Common names.

  Names that aren't in the standard set of XML names will be treated as custom field names.

  Names that don't match anything trigger an error showing all the names that didn't match.

  ## Examples

      iex> Infusionsoft.Schemas.from_xml(["FirstName"], "test_token", :contacts)
      {:ok, ["First Name"]}

      iex> Infusionsoft.Schemas.from_xml(["LastName"], "test_token", :not_a_valid_type)
      {:error, "The type \\"not_a_valid_type\\" is invalid"}

      iex> Infusionsoft.Schemas.from_xml(["Not a valid name"], "test_token", :contacts)
      {:error, "The name \\"Not a valid name\\" is not a standard or custom contact field"}
  """
  @spec from_xml([String.t()], String.t(), atom()) :: {:ok, list()} | {:error, String.t()}
  def from_xml(names, token, :contacts) when is_list(names), do: XML.Contacts.from(names, token)

  def from_xml(names, _token, type) when is_list(names),
    do: {:error, ~s(The type "#{type}" is invalid)}

  @doc """
  Takes a map of key / value pairs with Common name keys and returns the map with XML name keys.

  Names that aren't in the standard set of Common names will be treated as custom field names.

  Names that don't match anything trigger an error showing all the names that didn't match.
  """
  @spec keys_from_xml(map(), String.t(), :contacts) :: {:ok, map()} | {:error, binary()}
  def keys_from_xml(map, token, :contacts) do
    pairs = Enum.map(map, fn {k, v} -> {from_xml([k], token, :contacts), v} end)

    case Enum.filter(pairs, fn {{status, _}, _} -> status == :error end) do
      [] ->
        {:ok, Enum.into(pairs, %{}, fn {{_, [k]}, v} -> {k, v} end)}

      errors ->
        {:error, errors |> Enum.map(fn {{_, message}, _} -> message end) |> Enum.join(", ")}
    end
  end
end
