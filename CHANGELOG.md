CHANGELOG
=========
0.8.1
* The more extensive changes in 0.8.0 have been reverted in favor of more surgical changes
* Better testing and validation to make sure the changes acutally work

0.8.0
-----
* Removed support for legacy API keys in response to Infusionsoft deprecating them (see https://developer.infusionsoft.com/legacy-key-deprecation/)
* Moved minimum version of Elixir to 1.9
* Moved away from Mix Config and implmented Config
* Updated locked dependencies
* Updated README to reflect that the project probably won't see updates unless they're requested

0.7.0
-----
* Switched HTTP client from Mojito to Finch because of intermittent timeouts

0.6.4
-----
* Fixed issue where Infusionsoft XML api was failing all calls because it stopped accepting an empty string for the token.

0.6.3
-----
* Updated typespecs to fix warnings

0.6.2
-----
* Fixed a bug where genserver would break when Mojito sent message back about closed connection.

0.6.1
-----
* Fixed a bug with the return value of query_table being a list of :ok tuples.

0.6.0
-----

* Better translation for REST

* New REST endpoints for Contacts

* Switched out HTTPoison for Mojito

0.5.0
-----

* Fixed a problem with `query_table/5` where the raw XML names were returned instead of the display names.


0.4.0
-----

BREAKING CHANGES (`Infusionsoft.Endpoint.XML` sub-modules only):
* **
* Updated many of the function names to match the labels on the left navigation in the Infusionsoft docs. This will help map things more closely between the docs and the functions.

* Modified the order of arguments in many of the functions for consistency with the Infusionsoft docs. Doublecheck your calls to make sure you have the order right.
* **

* Finished adding `Infusionsoft.Endpoints.XML` sub-modules. XML endpoints are now complete.
  
* Modified argument names in `Infusionsoft.Endpoints.XML` sub-modules so they match the Infusionsoft documentation exactly. The exception are functions with optional arguments, which have been put into a conventional keyword list as the last argument and the documentation for those functions show the available options.

0.3.0
-----

* Added a lot of new endpoints in `Infusionsoft.Endpoints.XML.Data`
  
* Added a new function in the main `Infusionsoft` module to get access to querying all results of a table. This works fully on the "Contact" table because of the field name caching, but will probably break on other tables for now.

0.2.1
-----

* Recursive helper function added to `Infusionsoft.Endpoints.XML.Data` to allow returning _all_ results instead of by page.

0.2.0
-----

* Functions in `Infusionsoft` module fully operational.

* Ability to use legacy API keys added.
  
* New XML endpoint added to query data tables.
  
* Contact Custom Field cache added, and with it the ability for the XML schema to return appropriate errors and field names when custom fields are required.

* Updates to README to reflect status of project.

0.1.0
-----

* First tagged version.