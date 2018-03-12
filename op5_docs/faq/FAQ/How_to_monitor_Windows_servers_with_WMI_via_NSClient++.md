# How to monitor Windows servers with WMI via NSClient++

This how-to is for monitoring Windows hosts using WMI through NSClient++. For agentless monitoring of Windows hosts please see this how-to: [Agentless Monitoring of Windows using WMI](https://kb.op5.com/display/HOWTOs/Agentless+Monitoring+of+Windows+using+WMI)

## **Introduction**

Using op5 Monitor in combination with Windows Management Instrumentation (WMI) system administrators can query, change, and monitor configuration settings on desktops and servers in their IT environment.

In this how-to we will add a service looking for accounts that are enabled in Windows and have their password set to never expire. The monitoring is made by using check\_nrpe with the agent NSClient++ using CheckWMI.

More information about WMI classes:
 <http://msdn.microsoft.com/en-us/library/aa394084%28v=VS.85%29.aspx>

## **Prerequisites**

Before we can start monitoring Windows servers using WMI we need to make sure NSClient++ is installed and configured to allow arguments.

## **Configuring NSClient++**

When we are making changes to the NSClient++ configuration we shall make them in the file called: custom.ini It is found in the colder where NSClient++ is installed on the host.

To configure NSClient++,

1.  Open up custom.ini in Notepad
2.  Add the following lines to custom.ini 
    [NRPE]

        allow_arguments=1

        allow_nasty_meta_chars=1

3.  Restart the NSClient++ service

## **Adding a check\_command to op5 Monitor**

Now we will add a new check\_command to op5 Monitor. This check\_command will let you set a few arguments when adding a new service later on.

To add check\_command to op5 Monitor:

1.  Open up Configure in op5 Monitor
2.  Click “Commands”
3.  Add a new check\_command with the following settings

Option

Value

command\_name

check\_WMI\_nopasswordexpiry

command\_line

\$USER1\$/opt/plugins/check\_nrpe -H \$HOSTADDRESS\$ -p 5666 -c CheckWMI -a truncate=100 CheckWMI MaxCrit=\$ARG2\$ MaxWarn=\$ARG1\$ “Query:badUsers=Select Name, PasswordExpires, Disabled from Win32\_UserAccount” “columnSyntax=%Name%” “columnSeparator= , ” +filter-numeric:PasswordExpires==0 +filter-numeric:Disabled==0

**\$ARG1\$:** Warning level
 **\$ARG2\$:** Critical level

## **Adding a service to op5 Monitor**

To add a new service to op5 Monitor:

1.  Open up the host you like to monitor and chose “Add new service”.
2.  Set at least the following options:

    Option

    Value

    service\_description

    WMI: Enabled accounts with passwords that never expires

    check\_command

    check\_WMI\_nopasswordexpiry

    check\_command\_args

    1!2

3.  Click “Apply” and then “Save”.

 

