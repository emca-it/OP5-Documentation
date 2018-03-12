# Monitor to Logserver Integration

You can use op5 Monitor to query op5 LogServer on how many matches a filter return and then throw OK|WARNING|CRITICAL values depending on the information returned. You can also get a url in your Monitor window that points to the op5 LogServer with the current filter checked.

## Prerequisites

Before you begin you need to have op5 Monitor and op5 LogServer configured and up and running.

-   op5 Monitor
    -   Updated to latest release
-   op5 LogServer
    -   Updated to latest release
    -   A user created with access to the filters you will use
    -   One or more working filters

 

*Avoid spaces in your filtername*

 

## Monitor check-commands

Add the required check-commands, if they don’t already exist in your configuration. (‘Configure’ -\> ‘Check Commands’ -\> ‘New command’):

command\_name

command\_line

check\_logserver\_filter

\$USER1\$/check\_ls\_log -r \<logserverhost\> -l \<user\> -p \<password\> -f "\$ARG1\$" -i 10 -w \$ARG2\$ -c \$ARG3\$

check\_logserver\_filter\_interval

\$USER1\$/check\_ls\_log -r \<logserverhost\> -l \<user\> -p \<password\> -f "\$ARG1\$" -i \$ARG2\$ -w \$ARG3\$ -c \$ARG4\$

check\_logserver\_host\_filter

\$USER1\$/check\_ls\_log -r \<logserverhost\> -l \<user\> -p \<password\> -f "\$ARG1\$" -H “\$ARG2\$” -i \$ARG3\$ -w \$ARG4\$ -c \$ARG5\$

*\<user\> and \<password\> must be a valid user/password in op5 Logserver.*

 

## Service example

**service\_description**

**check\_command**

**check\_command\_args**

Failed Logins Total

check\_logserver\_filter

\<filter\>!\<warn\>!\<crit\>
**Ex:** Failed\_Logins!14!29

Failed Backup Jobs (24hours)

check\_logserver\_filter\_interval

\<filter\>!\<interval min\>!\<warn\>!\<crit\>
**Ex:** Failed\_Backup\_Jobs!1440!0!0

Critical Events

check\_logserver\_host\_filter

\<hostname\>!\<filter\>!\<interval\>!\<warn\>!\<crit\>
**Ex:** w2k3srv01!Critical!15!0!2

Failed Logins

check\_logserver\_host\_filter

\<hostname\>!\<filter\>!\<interval\>!\<warn\>!\<crit\>
**Ex:** linuxserver01!Failed\_Logins!20!2!9

 

 

