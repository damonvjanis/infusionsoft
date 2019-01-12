CHANGELOG
=========

0.3.0
-----

 *  Added a lot of new endpoints in `Infusionsoft.Endpoints.XML.Data`
 *  Added a new function in the main `Infusionsoft` module to get access to querying all results of a table. This works fully on the "Contact" table because of the field name caching, but will probably break on other tables for now.

0.2.1
-----

 *  Recursive helper function added to `Infusionsoft.Endpoints.XML.Data` to allow returning _all_ results instead of by page.

0.2.0
-----

 *  Functions in `Infusionsoft` module fully operational.

 *  Ability to use legacy API keys added.
  
 *  New XML endpoint added to query data tables.
  
 *  Contact Custom Field cache added, and with it the ability for the XML schema to return appropriate errors and field names when custom fields are required.

 * Updates to README to reflect status of project.

0.1.0
-----

 * First tagged version.