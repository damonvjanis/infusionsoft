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
end
