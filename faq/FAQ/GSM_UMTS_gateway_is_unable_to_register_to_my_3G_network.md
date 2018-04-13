# GSM/UMTS gateway is unable to register to my 3G network

## Question

* * * * *

My GSM/UMTS gateway is unable to register to my 3G network

## Answer

* * * * *

Currently we have three models of SMS gateways in production:

- Siemens/Cinterion MC55i - the oldest version, GSM, square, with slide-out tray for SIM
- Siemens/Cinterion TC65 - the previous version, GSM, rectangular, with slide-out tray for SIM
- CEP HT910G - the current version, GSM/UMTS (3G) square, with slide-away lid on SIM compartment

It appears that some CEP HT910G GSM/UMTS SMS gateways were misconfigured from the factory, such that they don't actually speak UMTS, but only GSM, by default.

In order to fix this, you will need to send the following commands to the modem (via, for example, minicom) before putting it into production:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
AT+WS46=25
AT&W
```

This will enable the 3G side of the modem, and is all you need to do, the modem will automatically find any 3G networks the SIM is enabled for and connect to them.

* * * * *
