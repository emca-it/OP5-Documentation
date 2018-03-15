# How do I monitor Microsoft SQL server 2012?

## Question

* * * * *

How do I monitor the health of a MSSQL 2012 server with *op5 Monitor*?

## Answer

* * * * *

We include the "check\_mssql\_health" plugin with a bunch of pre-configured commands for monitoring various aspects like cache hit ratios and job statuses.
To use it with Microsoft SQL server 2012 or later you will have to change the TDS version in "/etc/freetds.conf" to "8.0".

 

