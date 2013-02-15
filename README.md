Colibri-Entities-Finder
=========================

The free colibri version lacks on entities search on the database. This will be used to complement it.

Features
--------

Search for something in fields that are not allowed by the Colibri interface.

Click on a row to copy the client code to the clipboard.

Customize the fields shown on the table.


Frameworks
----------
Some frameworks that i have used.

### SPMySQL

This framework has been developed by the Sequel Pro team, and can be used to connect through Objective-C to MySQL.
The framework uses the C functions provided by the mysql library, to connect to the database.


TODO
----
Create a preference panel to customize some options like hostname, username, port, database, table, table fields, amoung others.

Use the customized fields in the preferences file to perform the filter. For now, it is static.

Create options to customize the field to copy when row clicked. It's useful when any change occurs on the database.

Customize if the user wants to copy or not the field to the clipboard.