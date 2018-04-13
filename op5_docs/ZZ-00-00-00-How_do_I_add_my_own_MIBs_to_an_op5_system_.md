# How do I add my own MIBs to an OP5 system?

## Question

* * * * *

How do I add my own MIBs to an OP5 system?

## Answer

* * * * *

Just copy them to /usr/share/snmp/mibs

If you wish for the MIB's to be usable with for example snmpwalk, you can create /etc/snmp/snmp.conf and add the MIB's you installed to it.

 

For example:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
mibs +CISCO-RHINO-MIB
mibs +SOME-OTHER-SPIFFY-MIB
```
