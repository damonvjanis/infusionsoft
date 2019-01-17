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

  alias Infusionsoft.Endpoints.XML.Contact, as: ContactsXML
  alias Infusionsoft.Endpoints.XML.Funnel, as: FunnelXML
  alias Infusionsoft.Endpoints.XML.Data, as: DataXML
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
  @spec create_contact(map(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, binary()}
  def create_contact(data, token, app \\ nil) do
    with {:ok, token} <- check_token(token),
         {:ok, data} <- Schemas.keys_to_xml(data, token, app, :contacts) do
      ContactsXML.create_a_contact(data, token, app)
    end
  end

  @doc """
  Retrieves a contact record from Infusionsoft.

  ## Examples

      iex> Infusionsoft.retrieve_contact(12345, ["First Name", "Last Name"], "test_token")
      {:ok, %{"First Name" => "Damon", "Last Name" => "Janis"}}
  """
  @spec retrieve_contact(integer(), [String.t()], String.t(), nil | String.t()) ::
          {:ok, map()} | {:error, String.t()}
  def retrieve_contact(id, fields, token, app \\ nil) do
    with {:ok, token} <- check_token(token),
         {:ok, fields} <- Schemas.to_xml(fields, token, app, :contacts),
         {:ok, contact} <- ContactsXML.retrieve_a_contact(id, fields, token, app) do
      Schemas.keys_from_xml(contact, token, app, :contacts)
    end
  end

  @doc """
  Updates a contact record from Infusionsoft.

  ## Examples

      iex> Infusionsoft.update_contact(12345, %{"Nickname" => "Dame"}, "test_token")
      {:ok, 12345}
  """
  @spec update_contact(integer(), map(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, String.t()}
  def update_contact(id, data, token, app \\ nil) do
    with {:ok, token} <- check_token(token),
         {:ok, data} <- Schemas.keys_to_xml(data, token, app, :contacts) do
      ContactsXML.update_a_contact(id, data, token, app)
    end
  end

  @doc """
  Achieves a goal for a contact, with a specific integration name and call name.

  ## Examples

      iex> Infusionsoft.achieve_goal(12345, "test_token")
      {:ok, [...]}
  """
  @spec achieve_goal(integer(), String.t(), String.t(), String.t(), nil | String.t()) ::
          {:ok, list()} | {:error, String.t()}
  def achieve_goal(contact_id, integration_name, call_name, token, app \\ nil) do
    with {:ok, token} <- check_token(token) do
      FunnelXML.achieve_a_goal(contact_id, integration_name, call_name, token, app)
    end
  end

  @doc """
  Gets all of the records from a table in Infusionsoft.

  See the available tables here:
  https://developer.infusionsoft.com/docs/table-schema/

  Available options for `opts` param:
  order_by - defualts to Id
  ascending - defaults to false

  ## Examples

      iex> Infusionsoft.query_table(%{"First Name" => "Damon"}, "Contact", ["Id"], "test_token", nil)
      {:ok, [%{"Id" => 12345}, %{"Id" => 67890}]}
  """
  @spec query_table(map(), String.t(), [String.t()], String.t(), nil | String.t(), keyword()) ::
          {:ok, list()} | {:error, binary()}
  def query_table(data, table, fields, token, app, opts \\ []) do
    if table == "Contact" do
      with {:ok, token} <- check_token(token),
           {:ok, data} <- Schemas.keys_to_xml(data, token, app, :contacts),
           {:ok, fields} <- Schemas.to_xml(fields, token, app, :contacts) do
        DataXML.query_all_from_table(data, table, fields, token, app, opts)
      end
    else
      {:error, "Only queries to the \"Contact\" table are currently supported"}
    end
  end
end
