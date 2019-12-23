CHANGELOG
=========
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