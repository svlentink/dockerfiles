# backofficebase

The previous version of the Superbuddy backoffice uses some libraries on top of composer (PHP).
This Docker image contains the base on which the backoffice is build.
The next Docker image uses `FROM superbuddy/backofficebase` and specifies the ENVironment variables,
PORTS and ENTRYPOINT.