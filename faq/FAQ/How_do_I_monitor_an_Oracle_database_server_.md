# How do I monitor an Oracle database server?

## Question

* * * * *

How do I monitor an Oracle database server?

## Answer

* * * * *

You can monitor an Oracle Installation from our Monitor server if you install Oracle Instant Client and use the plugin check\_oracle.pl.

check\_oracle.pl is designed in co-operation with an Oracle DBA and focuses on automating common DBA-tasks.

check\_oracle.pl depends on Oracle Instant Client and a user with sufficient access to the databases you want to monitor. The plugin can monitor:

- database availability (tnsping)

- login or dummy login

- cache hit ratio

- tablespace usage

- datafile usage

- total number of datafiles

- available extents per table or tablespace

- log archiving enabled or not

- backupmode

- user defined query, match for string or numeric value - locks

- broken transactions

- failed transactions

- transactions in the deferred error queue

- invalid transactions

The plugin supports placing authentication credentials in an auth-file and can handle hostname as input instead of using a .ora-file for SID-lookups. Further information is available in our how-to ["check\_oracle with Oracle Instant Client".](http://www.op5.com/how-to/check_oracle-with-oracle-instant-client/)
