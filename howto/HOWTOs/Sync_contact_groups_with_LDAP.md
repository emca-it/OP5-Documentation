# Sync contact groups with LDAP

The LDAP Helper module can be used in organizations desiring to utilize LDAP groups to populate contact groups in OP5 Monitor.

Version & Support

This article was written for version 7.3.5 of Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by op5 Support.

## Installation

Setup steps for the LDAP helper module:

Only install on the master, not master-peers. With the exception of needing to have LDAP sync on master-peers in the event of a fail over scenario (rare).

1.  Download the [ldap helper module archive (zip).](attachments/19072840/19235245.zip)
2.  Extract the folder to /opt on the OP5 server.

## Configure

Configure the LDAP helper module :

1.  Modify: /opt/op5-ldap-helper/op5-ldap-helper.conf.yml
    1.  Verify lines 2 & 3 match the name of the auth connector driver. (i.e. LDAP)

        NOTE: The sync action utilizes the existing LDAP Auth Module configuration.

    2.  Modify lines 26 & 27 if you would like to filter for specific groups.
        1.  custom\_group\_filter - For adding (cn=\*GROUP\_NAME\*) include the asterisks but change GROUP\_NAME of the group would "enable" OP5 to scan this specific group. 

    3.  Modify lines 46 & 47 with the user for API access to OP5 Monitor.
        1.  op5api - In order for the script to work with OP5 a user "apiuser" was created in OP5. The credentials are stored in this file.

2.  Setup a contact group prefaced with "LDAP\_" for example "LDAP\_testgroup".

## Using the module

Running the script to sync groups :

1.  Once the group is configured within the config file run go to /opt/op5-ldap-helper/ and run the following: ./[op5-ldap-helper.pl](http://op5-ldap-helper.pl)
2.  To see available help use: ./[op5-ldap-helper.pl](http://op5-ldap-helper.pl) -h
3.  To perform a dry run (no save), and get detailed output use: ./[op5-ldap-helper.pl](http://op5-ldap-helper.pl) -d -C -n
4.  To perform a run with sync, simply run: ./[op5-ldap-helper.pl](http://op5-ldap-helper.pl)
5.  Consider creating a cron job to periodically sync groups.

## Related articles

-   Page:
    [Sync contact groups with LDAP](/display/HOWTOs/Sync+contact+groups+with+LDAP)
-   Page:
    [Active Directory Integration How-To](/display/HOWTOs/Active+Directory+Integration+How-To)

