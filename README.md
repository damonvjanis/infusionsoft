# Infusionsoft

## Introduction

So much more than a wrapper!

The Infusionsoft API is robust but there are a lot of quirks that can trip you up. Most significantly, Infusionsoft offers two API's instead of one: a newer REST API and an older XML-RPC API. Unfortunately, there are wildly significant differences between these API's in what data is available, and even field names. As an example, the contact field “First Name” that you see in the application has a backend name of “FirstName” in the XML API and a backend name of “given_name” in the REST API.

This package intends to abstract the things that make the Infusionsoft API challenging to work with, and provide a unified interface for developers so that developers can leverage both the XML API and the REST API without being concerned with the details of each.

This is very much a work in progress and under active development, so if you are thinking about putting something in production with this library plase reach out and contact the maintainer first! (damonvjanis@gmail.com) Here is what it currently does and then a list of the goals yet to be accomplished.

* **
Big milestone reached! The functions in `Infusionsoft.Endpoints.XML.<submodules>` have reached completion! If all you need is a wrapper for the XML endpoints, you can call directly into these modules with confidence that they are stable. The function names and arguments have been updated to very closely follow the documentation at https://developer.infusionsoft.com/docs/xml-rpc/. For every header on the left navigation, you will find a matching module name under `Infusionsoft.Endpoints.XML`. For every item under the heading in the Infusionsoft docs, you will find a matching function in the module. The names are as close as possible to the labels and argument names from the documentation there, which should help with navigation.
* **

### Currently available:

- Through the main module, `Infusionsoft`, there are a handful of functions available to work with contacts, fire API goals, and query data tables (one of the most useful).
- OAuth2 tokens are supported and are the recommended mode of authentication. If you want to use legacy API keys, you can do so on functions that accept an `app` argument. Just use the encrypted key from Infusionsoft for `token`, and use the Infusionsoft application name, like `ab123` for `app`.
- To obtain an OAuth token, read Infusionsoft's guide [here](https://developer.infusionsoft.com/getting-started-oauth-keys/).
- Contact custom fields are automatically cached and refreshed every 15 minutes once you've used a call that requires accessing custom fields. This allows the developer to use the display name for custom fields, instead of worrying about what the exact API names are.
- All of the XML endpoints have been wrapped in the lower level `Infusionsoft.Endpoints.XML` modules. You have to use the XML field names when you access these modules, but it provides a lot of raw access. They work with both OAuth tokens (omit or pass `nil` for the `app` argument) or with legacy encrypted keys (use the key for the `token` argument and the app name like `ab123` for the `app` argument).

### Goals yet to be accomplished:

- Provide a cache for tag names and ID's, and expose the endpoints to apply and remove tags in the main module.
- Expose all raw REST endpoints in their respective modules
- Wrap each raw endpoint with a function in the main `Infusionsoft` module so that display names can be used (and returned), and the developer doesn't need to worry about which API the function is using.
- Add a rate limiter that can be toggled on or off with configuration that limits the number of outgoing API calls to be beneath the maximum of 25 calls per second.
- Provide a host of convenience functions in the main `Infusionsoft` module that don't map exactly to any raw endpoints but represent common needs. For example, a function that retrieves all contacts who have a certain tag applied.

## Installation

The package can be installed
by adding `infusionsoft` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:infusionsoft, "~> 0.5.0"}
  ]
end
```

Documentation can
be found at [https://hexdocs.pm/infusionsoft](https://hexdocs.pm/infusionsoft).

## Implementation guide
The intention of the package is to abstract the nuances of Infusionsoft's REST and XMLRPC API's so that the developer doesn't have to worry about the differences.

The two API's have different field names, so in most other libraries the developer has to be familiar with those names and the strucure of each API to get things to work.

In this library, we use the _display_ field names and the library translates into the correct names and structures depending on the API that is being used.

For example, when you use the function `Infusionsoft.create_contact/2`, you don't have to worry about underlying field names. Just look in your Infusionsoft application, and use the display names from there. Like so:

```elixir
data = %{
  "First Name" => "John",
  "Last Name" => "Smith",
  "Email" => "infusionsoft@example.com",
  "Phone 1" => "123-456-7890",
  "Some custom field" => "Foo Bar Baz"
}

Infusionsoft.create_contact(data, "your_oauth_token")
```

To retrieve a contact record, you would call the following function:

```elixir
contact_id = 12345
fields = ["First Name", "Last Name", "Some custom cield"]

Infusionsosft.get_contact(contact_id, fields, "your_oauth_token")
```

and it would return something like this:
```elixir
%{
  "First Name" => "John",
  "Last Name" => "Smith",
  "Some Custom Field" => "Foo Bar Baz"
}
```