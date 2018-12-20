# Infusionsoft

This package provides a complete wrapper for the Infusionsoft API.

The intention is to abstract the nuances of Infusionsoft's REST and XMLRPC API's so that the developer doesn't have to worry about the differences.

The two API's have different field names, so in most other libraries the developer has to be familiar with the names and strucures of each API to get things to work.

Instead, we use the _display_ field names and the library translates into the correct names and structures depending on the API that is being used.

For example, the field name `First Name` (which is a display name) would be changed to `FirstName` if the request used the XMLRPC API and `given_name` if the request used the REST api.

On this initial release (0.1.0), things are still pretty rough and will change very rapidly.

For example, the main module Infusionsoft has functions that only use the XMLRPC API and expect the developer to use the appropriate field names.

Documentation is a work in progess, although some of the lower level API's have better tests and documentations.

My intention was to push out an initial release very early in the development process so that it could be used in some projects I have going on currently, and then expand in improve the package as my spare time allows.

## Installation

The package can be installed
by adding `infusionsoft` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:infusionsoft, "~> 0.1.0"}
  ]
end
```

Documentation can
be found at [https://hexdocs.pm/infusionsoft](https://hexdocs.pm/infusionsoft).

## Usage

The API is designed so that you can access everything through the `Infusionsoft` module using display names instead of worrying about which API you are using.

However, if you want to directly access the REST or XML functions, you can find them documented in the `Infusionsoft.Endpoints.REST.<object_type>` or `Infusionsoft.Endpoints.XML.<object_type>` modules.