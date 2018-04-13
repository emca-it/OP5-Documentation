# HowTo test SMS-Modem using minicom

## Question

* * * * *

How do I test my SMS-Modem using a terminal emulator such as Minicom?

## Answer

* * * * *

Jump to step 5 to skip Minicom configuration.

1. Use the built in logs to identify the different serial ports on your system.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
root@monitor:~# dmesg | grep tty
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A 00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A 00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
```

2. Start Minicom

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
root@monitor:~# minicom
```

You should see "Initializing Modem" followed by "Welcome to Minicom".

If you get something like:

minicom: WARNING: configuration file not found, using defaults Device /dev/modem access failed: No such file or directory.

Then run:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
root@monitor:~# minicom -s
```

    Select Serial port setup > A and set correct device, i.e. /dev/ttyS0

Baudrateshould be 115200 in minicom.

Press Enter, then select Save setup asdfl. You should now see "Initializing Modem" or be able to run Minicom

3. If necessary, Press CTRL-A then Z to entermenu.

Selectport connected tomodem:

Press O \> Serial port setup, press A to G fordeviceto use and settings. Press Enter to exit.

4. You may want to turn local Echo on so that you can see your commands: From Menu (CTRL-A then Z), press E.

From Welcome screen "E1" and Enter

5. Test modem:

From Welcome screen, type "ATI" to get status:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
ATI
SIEMENS MC35i REVISION 01.03
```

Type: AT+CREG? to get network status:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
AT+CREG?
+CREG: 0,1
```

+CREG: \<mode\>,\<stat\>[,\<Lac\>,\<Ci\>[,\<AcT\>]]

where
\<stat\>
0 - not registered, ME is not currently searching a new operator to register to
1 - registered, home network
2 - not registered, but ME is currently searching a new operator to register to
3 - registration denied
4 -unknown
5 - registered, roaming
where:
\<Lac\> - Local Area Code for the currently registered on cell
\<Ci\> - Cell Id for the currently registered on cell
\<AcT\>: access technology of the registered network:
0 GSM
2 UTRAN
Note: \<Lac\>, and \<Ci\> and \<AcT\> are reported only if \<mode\>=2 and the
mobile is registered on some network cell.

Type: AT+CPIN? to get SIM PIN status:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
AT+CPIN?
+CPIN: READY
```

+CPIN: \<code\>
where:
\<code\> - PIN/PUK/PUK2 request status code
READY - ME is not pending for any password
SIM PIN - ME is waiting SIM PIN to be given
SIM PUK - ME is waiting SIM PUK to be given
PH-SIM PIN - ME is waiting phone-to-SIM card password to be given
PH-FSIM PIN - ME is waiting phone-to-very first SIM card password to be given
PH-FSIM PUK - ME is waiting phone-to-very first SIM card unblocking password to be given
SIM PIN2 - ME iswaiting SIM PIN2 to be given; this \<code\> is returned only when the last executed command resulted in PIN2 authentication failure (i.e. +CME ERROR: 17)

SIM PUK2 - ME is waitingSIM PUK2 to be given; this \<code\> is returned only when the last executed command resulted in PUK2 authentication failure (i.e. +CME ERROR: 18)
PH-NET PIN - ME is waiting network personalization password to be given
PH-NET PUK - ME is waiting network personalization unblocking password to be given
PH-NETSUB PIN - ME is waiting network subset personalization password to be given
PH-NETSUB PUK - ME is waiting network subset personalization unblocking password to be given
PH-SP PIN - ME is waiting service provider personalization password to be given
PH-SP PUK - ME is waiting service provider personalization unblocking password to be given
PH-CORP PIN - ME is waiting corporate personalization password to be given
PH-CORP PUK -ME iswaiting corporate personalization unblocking password to be given

Type: AT+CSQ to get signal strength:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
AT+CSQ
+CSQ: 17,99
```

+CSQ: \<rssi\>,\<ber\>
where
\<rssi\> - received signal strength indication
0 - (-113) dBm or less
1 - (-111) dBm
2..30 - (-109)dBm..(-53)dBm / 2 dBm per step
31 - (-51)dBm or greater
99 - not known or not detectable
\<ber\> - bit error rate (in percent)
0 - less than 0.2%
1 - 0.2% to 0.4%
2 - 0.4% to 0.8%
3 - 0.8% to 1.6%
4 - 1.6% to 3.2%
5 - 3.2% to 6.4%
6 - 6.4% to 12.8%
7 - more than 12.8%
99 - not known or not detectable

6. Exit Minicom:

CTRL-A then Z then X, you should see "Resetting modem"

For more help about minicom, eitherdo:man minicom or minicom --help.

For more information about Hayes AT commands, see: <http://home.intekom.com/option/hayesat.htm>

### Other useful commands/information

**Sending SMS**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
AT+CMGF=1
AT+CMGS="+4670xxxxxx"
Write message here. <ctrl+z>
```

#### Humanreadable signal strength

Signal strength will be reported insmsd.logif verbosity is increased to 7 in /etc/smsd.conf. If there'salotof information in /var/log/smsd/smsd.log and you can't find the right line, use grep and search för dBm.

# OP5 Monitor: Open Source Network Monitoring

[OP5 ](https://www.op5.com/)is the preferred Open Source Networking & Server Monitoring tool for large multi-national companies in over 60 markets. If you would like to experience OP5 Monitor you can get started here, alternatively, if you prefer to get more hands on you can Download OP5 Monitor for free.
