defmodule Infusionsoft.Endpoints.XML.File do
  @moduledoc """
  Provides the raw endpoints to Infusionsoft's XML API for File actions.
  """
  alias Infusionsoft.Endpoints.XML.Helpers

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#file-upload-a-file"
  @spec upload_a_file(integer(), String.t(), String.t(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, String.t()}
  def upload_a_file(contact_id, file_name, base_64_encoded_data, token, app \\ nil) do
    params = Helpers.build_params([contact_id, file_name, base_64_encoded_data], token, app)
    Helpers.process_endpoint("FileService.uploadFile", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#file-retrieve-a-file"
  @spec retrieve_a_file(integer(), String.t(), nil | String.t()) ::
          {:ok, String.t()} | {:error, String.t()}
  def retrieve_a_file(file_id, token, app \\ nil) do
    params = Helpers.build_params([file_id], token, app)
    Helpers.process_endpoint("FileService.getFile", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#file-retrieve-a-file-download-url"
  @spec retrieve_download_url(integer(), String.t(), nil | String.t()) ::
          {:ok, String.t()} | {:error, String.t()}
  def retrieve_download_url(file_id, token, app \\ nil) do
    params = Helpers.build_params([file_id], token, app)
    Helpers.process_endpoint("FileService.getDownloadUrl", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#file-replace-a-file"
  @spec replace_a_file(integer(), String.t(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, String.t()}
  def replace_a_file(file_id, base_64_encoded_data, token, app \\ nil) do
    params = Helpers.build_params([file_id, base_64_encoded_data], token, app)
    Helpers.process_endpoint("FileService.replaceFile", params, token, app)
  end

  @doc "https://developer.infusionsoft.com/docs/xml-rpc/#file-rename-a-file"
  @spec rename_a_file(integer(), String.t(), String.t(), nil | String.t()) ::
          {:ok, integer()} | {:error, String.t()}
  def rename_a_file(file_id, file_name, token, app \\ nil) do
    params = Helpers.build_params([file_id, file_name], token, app)
    Helpers.process_endpoint("FileService.renameFile", params, token, app)
  end
end
