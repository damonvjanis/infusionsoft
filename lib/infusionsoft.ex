defmodule Infusionsoft do
  @moduledoc """
  Functions for interacting with Infusionsoft API.

  One important thing to note is that if you have multiple custom fields with the same name,
  even if the capitalization is different, things may not work the way you expect.

  The same is true for tags. If you need to support tags with the same name in
  different categories, you can provide the category name as an option in all tag calls.
  However, if you have multiple tags in the same category with the same name, things
  may not work the way you expect.
  """

  alias Infusionsoft.Endpoints.XML.Contacts, as: ContactsXML
  alias Infusionsoft.Endpoints.XML.Funnel, as: FunnelXML
  alias Infusionsoft.Schemas

  defp check_token(nil), do: {:error, "Invalid token: nil"}
  defp check_token(""), do: {:error, "Invalid token: blank string"}

  defp check_token(token) when not is_binary(token),
    do: {:error, "Invalid token: #{inspect(token)}"}

  defp check_token(token), do: {:ok, token}

  @doc """
  Creates a contact record in Infusionsoft without doing a dupe check.

  ## Examples

      iex> Infusionsoft.create_contact(%{"First Name" => "Damon"}, "test_token")
      {:ok, 12345}
  """
  @spec create_contact(map(), String.t()) :: {:ok, integer()} | {:error, binary()}
  def create_contact(data, token) do
    with {:ok, token} <- check_token(token),
         {:ok, data} <- Schemas.keys_to_xml(data, token, :contacts) do
      ContactsXML.create(data, token)
    end
  end

  @doc """
  Achieves a goal for a contact, with a specific integration name and call name.

  ## Examples

      iex> Infusionsoft.achieve_goal(12345, "test_token")
      {:ok, [...]}
  """
  @spec achieve_goal(integer(), String.t(), String.t(), String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def achieve_goal(contact_id, integration_name, call_name, token) do
    with {:ok, token} <- check_token(token) do
      FunnelXML.achieve_goal(contact_id, integration_name, call_name, token)
    end
  end
end
