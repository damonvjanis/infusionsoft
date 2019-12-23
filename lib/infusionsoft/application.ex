defmodule Infusionsoft.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Infusionsoft.Caches.ContactCustomFields,
      Infusionsoft.Caches.Companies,
    ]

    opts = [strategy: :one_for_one, name: Infusionsoft.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
