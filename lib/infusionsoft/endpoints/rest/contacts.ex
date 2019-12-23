defmodule Infusionsoft.Endpoints.REST.Contact do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's REST API for Contact.
  """

  alias Infusionsoft.Endpoints.REST.Helpers

  @doc """
  https://developer.infusionsoft.com/docs/rest/#!/Contact/listContactsUsingGET

  Available Parameters:
  %{
    limit: integer(),
    offset: integer(),
    email: String.t(),
    given_name: String.t(),
    family_name: String.t(),
    order: String.t(),
    order_direction: String.t(),
    since: String.t(),
    until: String.t()
  }
  """
  @spec list_contacts(String.t(), map() | nil) :: {:ok, map()} | {:error, any()}
  def list_contacts(token, params \\ nil) do
    path = "/contacts" <> Helpers.build_params(params)
    Helpers.process_endpoint(path, :get, token)
  end

  @spec retrieve_a_contact(integer(), String.t(), [String.t()] | nil) ::
          {:ok, map()} | {:error, any()}
  def retrieve_a_contact(id, token, params \\ nil) do
    path = "/contacts/#{id}" <> Helpers.build_params(%{"optional_properties" => params})
    Helpers.process_endpoint(path, :get, token)
  end

  @spec update_a_contact(integer(), map(), String.t(), [String.t()] | nil) ::
          {:ok, map()} | {:error, any()}
  def update_a_contact(id, fields, token, params \\ nil) do
    path = "/contacts/#{id}" <> Helpers.build_params(%{"update_mask" => params})

    with body <- Jason.encode!(fields) do
      Helpers.process_endpoint(path, :patch, token, body)
    end
  end
end
