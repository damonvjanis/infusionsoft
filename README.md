# Infusionsoft

## Introduction

So much more than a wrapper!

The Infusionsoft API is robust but there are a lot of quirks that the developer has to accommodate for. As an example, the contact field “First Name” that you see in the application has a backend name of “FirstName” in the XML API and a backend name of “given_name” in the REST API.

This package intends to abstract the things that make the Infusionsoft API challenging to work with, and provide a unified interface for developers so that developers can leverage both the XML API and the REST API without being concerned with the details of each.

The package is very much a work in progress, so here is what it currently does and then a list of the goals yet to be accomplished.

### Currently available:

- Through the main module, `Infusionsoft`, there are a handful of functions available to work with contacts, fire API goals, and query data tables (one of the most useful).
- Most of the XML endpoints have been wrapped in the lower level `Infusionsoft.Endpoints.XML` modules. You have to use the XML names when you access these modules, but it provides a lot of raw access.
- OAuth2 tokens are supported and are the recommended mode of authentication. If you want to use legacy API keys, you can do so on functions that accept an `app` argument. Just use the encrypted key from Infusionsoft for `token`, and use the Infusionsoft application name, like `ab123` for `app`.
- Contact custom fields are automatically cached and refreshed every 15 minutes once you've used a call that requires accessing custom fields. This allows the developer to use the display name for custom fields, instead of worrying about what the exact API names are.

### Goals yet to be accomplished:

- Provide a cache for tag names and ID's, and expose the endpoints to apply and remove tags in the main module.
- Expose all raw XML and REST endpoints in their respective modules
- Wrap each raw endpoint with a function in the main `Infusionsoft` module so that display names can be used (and returned), and the developer doesn't need to worry about which API the function is using.
- Add a rate limiter that can be toggled on or off with configuration that limits the number of outgoing API calls to be beneath the maximum of 25 calls per second.
- Provide a host of convenience functions in the main `Infusionsoft` module that don't map exactly to any raw endpoints but represent common needs. For example, a function that retrieves all contacts who have a certain tag applied.

## Installation

The package can be installed
by adding `infusionsoft` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:infusionsoft, "~> 0.3.0"}
  ]
end
```

Documentation can
be found at [https://hexdocs.pm/infusionsoft](https://hexdocs.pm/infusionsoft).

## Implementation guide
The intention of the package is to abstract the nuances of Infusionsoft's REST and XMLRPC API's so that the developer doesn't have to worry about the differences.

The two API's have different field names, so in most other libraries the developer has to be familiar with those names and the strucure of each API to get things to work.

In this library, we use the _display_ field names and the library translates into the correct names and structures depending on the API that is being used.

For example, the field name `First Name` (which is a display name) would be changed to `FirstName` if the request used the XMLRPC API and `given_name` if the request used the REST api. The return values are translated _back_ into display names so in your application code you can always work with the display names.

For example, to retrieve a contact record, you would call the following function:

```
contact_id = 12345
fields = ["First Name", "Last Name", "Some Custom Field"]

Infusionsosft.get_contact(contact_id, fields, "your_oauth_token")
```

and it would return something like this:
```
%{
  "First Name" => "John",
  "Last Name" => "Doe",
  "Some Custom Field" => "Custom Field Value"
}
```

To obtain an OAuth token, read Infusionsoft's guide [here](https://developer.infusionsoft.com/getting-started-oauth-keys/).

In this release (0.2.0), we've expanded the XML part of the API and added some functions to the main Infusionosft module. We've also added support for the legacy Encrypted Key method of API calls for XML-RPC calls.

In order to use the encrypted key authentication method, you have to access to the XML functions directly or pass the optional `app` parameter to the functions in the main module. For example, calling `Infusionsoft.Endpoints.XML.Funnel.achieve_goal/5` with `token` being your encrypted key and `app` being your Infusionsoft application name (like `"ab123"`).

If you discover this library and are interested in using it, please contact me at damonvjanis@gmail.com so I can give you more information on the status of the project.

Documentation and tests are a work in progess, expect more of that to come.