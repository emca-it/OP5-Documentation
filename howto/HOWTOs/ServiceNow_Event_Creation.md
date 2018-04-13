# ServiceNow Event Creation

This guide provides the steps to add event creation bewteen OP5 and ServiceNow. These steps are based on ServiceNow integration through instructions and scripts available from ServiceNow. Easily implemented within op5, can also be used by any Nagios based patform.

## How to add event creation between op5 Monitor and ServiceNow

1. Review the following guide: <http://wiki.servicenow.com/index.php?title=Integrating_External_Events_with_Event_Management#gsc.tab=0>
2. Upload the python event creation script from ServiceNow, sendEventServiceNow.py.
3. Edit the Python script to update the default values of the endpoint, username, and password parameters.
4. Create a new command for host outage notifications, Manage \> Configure \> Commands
    1.  Description: host-notify-servicenow
    2.  Command: \$USER1\$/sendEventServiceNow.py --source="\$NOTIFICATIONTYPE\$" --node="\$HOSTNAME\$" --type="\$HOSTSTATE\$" --resource="\$HOSTOUTPUT\$" --severity="1"
    3.  All macros available can be found here: <https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/3/en/macrolist.html>
    4.  Create the same type of command for being notified about services (using service related macros within the command variables), named service-notify-servicenow

5. Create a new contact, Manage \> Configure \> Contacts
6. Set host notifications to DOWN, and service notifications to Critical and Warning only.
7. Set the host and service notifications to use the commands created.

BETA: The instrucitons above have not been production tested and should work but may require slight modificaiton to get configured for your environment specifically.

## Related articles

- Page:
    [ServiceNow Event Creation](/display/HOWTOs/ServiceNow+Event+Creation)
