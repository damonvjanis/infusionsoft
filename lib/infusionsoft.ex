defmodule Infusionsoft do
  @moduledoc """
  Main module for interacting with Infusionsoft, start here!

  If you want to access the XML-RPC API or the REST API without the caching and conveniences,
  you can use the other modules like `Infusionsoft.Endpoints.XML` and `Infusionsoft.Endpoints.REST`
  outlined in the documentation.

  One important thing to note is that if you have multiple custom fields with the same name,
  even if the capitalization is different, things may not work the way you expect.

  The same is true for tags. If you need to support tags with the same name in
  different categories, you can provide the category name as an option in all tag calls.
  However, if you have multiple tags in the same category with the same name, things
  may not work the way you expect.
  """

  alias Infusionsoft.Endpoints.XML.Contact, as: ContactXML
  alias Infusionsoft.Endpoints.REST.Contact, as: ContactREST
  alias Infusionsoft.Endpoints.XML.Funnel, as: FunnelXML
  alias Infusionsoft.Endpoints.XML.Data, as: DataXML
  alias Infusionsoft.Schemas

  defp check_token(nil), do: {:error, "Invalid token: nil"}
  defp check_token(""), do: {:error, "Invalid token: blank string"}

  defp check_token(token) when not is_binary(token),
    do: {:error, "Invalid token: #{inspect(token)}"}

  defp check_token(token), do: {:ok, token}

  @doc """
  Fetches all contact records, returning all fields and custom fields (very expensive).

  Currently this function does not support more than 1000 contacts, so if your app has more
  please use `query_table/6` which can return an unlimited number.

  Use `query_table/6` for more granular control over which fields are returned.

  ## Examples

      iex> Infusionsoft.list_contacts("test_token")
      {:ok, [%{"Id" => 12345}, %{"Id" => 67890}]}
  """
  @spec list_contacts(String.t(), map() | nil) :: {:ok, integer()} | {:error, binary()}
  def list_contacts(token, parameters \\ nil) do
    with {:ok, token} <- check_token(token),
         {:ok, %{"contacts" => contacts}} <- ContactREST.list_contacts(token, parameters),
         common_contacts <- map_from_rest(contacts, token),
         {:ok, contacts} <- check_for_errors(common_contacts),
         contacts = filter_blanks(contacts) do
      contacts
    end
  end

  defp map_from_rest(contacts, token) do
    for contact <- contacts do
      with {:ok, common} <- Schemas.REST.Contact.from_rest(contact, token), do: common
    end
  end

  defp check_for_errors(contacts) do
    case Enum.find(contacts, &is_tuple/1) do
      nil -> {:ok, contacts}
      {:error, error} -> {:error, error}
    end
  end

  defp filter_blanks(contacts) do
    for contact <- contacts, contact != %{}, do: contact
  end

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
      ContactXML.create_a_contact(data, token, app)
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
         {:ok, contact} <- ContactXML.retrieve_a_contact(id, fields, token, app) do
      Schemas.keys_from_xml(contact, token, app, :contacts)
    end
  end

  # This function definition uses the REST endpoint but should be functionaly equivalent
  # def retrieve_contact(id, fields, token) do
  #   with {:ok, token} <- check_token(token),
  #        {:ok, contact} <- ContactREST.retrieve_a_contact(id, token, ["custom_fields"]),
  #        {:ok, contact} <- Schemas.REST.Contact.from_rest(contact, token) do
  #     {:ok, contact |> Enum.filter(fn {k, _} -> k in fields end) |> Map.new()}
  #   end
  # end

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
      ContactXML.update_a_contact(id, data, token, app)
    end
  end

  # This function definition uses the REST endpoint but should be functionaly equivalent
  # @spec update_contact(integer(), map(), String.t()) ::
  #         {:ok, integer()} | {:error, String.t()}
  # def update_contact(id, data, token) do
  #   with {:ok, token} <- check_token(token),
  #        {:ok, data} <- Schemas.REST.Contact.to_rest(data, token) do
  #     ContactREST.update_a_contact(id, data, token)
  #   end
  # end

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
      FunnelXML.achieve_a_goal(integration_name, call_name, contact_id, token, app)
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
           {:ok, fields} <- Schemas.to_xml(fields, token, app, :contacts),
           {:ok, list} <- DataXML.query_all_from_table(table, data, fields, token, app, opts) do
        Enum.map(list, &Schemas.keys_from_xml(&1, token, app, :contacts))
      end
    else
      {:error, "Only queries to the \"Contact\" table are currently supported"}
    end
  end
end
