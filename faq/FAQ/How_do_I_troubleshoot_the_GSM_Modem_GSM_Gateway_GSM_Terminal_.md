# How do I troubleshoot the GSM Modem / GSM Gateway / GSM Terminal?

## Question

* * * * *

How do I troubleshoot the [GSM Modem / GSM Gateway / GSM Terminal](https://kb.op5.com/pages/viewpage.action?pageId=688553)?

## Answer

* * * * *

**Recommendations:**

Connect the modem directly to the OP5 Monitor server instead of using a Ethernet over Serial solution. This will guarantee that notifications can be sent even if the local network goes down.

 

**Troubleshooting Steps:**

1. Try to manually send yourself an SMS:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
root@monitor:~# smssend 46733333333 'Test'
```

Replace 46 with your country code. It may take a couple of minutes for the text message to reach your phone.

 

2. Check that the SMS daemon is running. You should get the following output with one or two random PID numbers at the end:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
root@monitor:~# service smsd status
smsd is running with pid: 2550 2544
```

 

3. Check how often the modem LED is blinking. Please read the "Overview of LED Operating Status" below for details.

 

4. Check the SMS daemon log for error messages by running:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
root@monitor:~# grep -i "error" /var/log/smsd.log
```

The command above might find an error line like this:

*2011-12-08 13:42:56,3, GSM1: Error: Modem is not registered to the network*

This could be three different problems:

-   The GSM signal is too weak.
-   The SIM card is missing.
-   The PIN code is incorrect or isn't configured.

5. If the server is a brand new OP5 Appliance machine from Dell, the COM1 port may be redirected to iDRAC.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
root@monitor:~# omreport chassis biossetup
```

If you get output saying:

Serial Communication
------------------------------------------
Serial Communication : On without Console Redirection
Serial Port Address : **Serial Device1=COM2,Serial Device2=COM1**
External Serial Connector : Serial Device 1
Failsafe Baud Rate : 115200
Remote Terminal Type : VT100/VT220
Redirection After Boot : Enabled

Run the following command:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
root@monitor:~# omconfig chassis biossetup attribute=SerialPortAddress setting=Serial1Com1Serial2Com2
```

The output from the omreport command above should now say:

Serial Communication
------------------------------------------
Serial Communication : On without Console Redirection
Serial Port Address : **Serial Device1=COM1,Serial Device2=COM2**
External Serial Connector : Serial Device 1
Failsafe Baud Rate : 115200
Remote Terminal Type : VT100/VT220
Redirection After Boot : Enabled

 

**Overview of LED Operating Status for Siemens MC35i / Cinterion TC65:**

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">Operating status
The blue/green LED is</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">Power down
Off</td>
<td align="left">Not registered to the GSM net (missing SIM card, and/or no/incorrect PIN code, and/or too weak GSM signal)
Blinking once every second</td>
</tr>
</tbody>
</table>

**Overview of LED Operating Status for CEP HT910G:**

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">Operating status
The green middle LED is</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">Power down
Off</td>
<td align="left">Not registered to the GSM net (searching, and/or too weak GSM signal)
Blinking once every second</td>
</tr>
</tbody>
</table>

6. Go through our [guide for how to test your modem using Minicom](HowTo_test_SMS-Modem_using_minicom).

