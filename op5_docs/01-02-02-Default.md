# Default

# About

For local users, the default driver can be used. This enables a local store of users at the OP5 Monitor server. It is recommended that you always keep this driver configured with an admin account as a fallback if the system is primarily using LDAP.

When the Default driver is enabled, a configuration interface, named **Local Users** appears in OP5 configuration.

In the local users page, each user has a real name, a password can be set, and group membership can be controlled. Groups needs to be created in advance. See Group Rights
This driver stores the users in the `auth_users` configuration file, located in `/etc/op5/auth_users.yml`.
