use Mix.Config

config :infusionsoft, Infusionsoft.Caches.ContactCustomFields, enabled: true

import_config "#{Mix.env()}.exs"
