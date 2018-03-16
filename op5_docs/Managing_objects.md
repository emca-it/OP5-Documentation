# Managing objects

# About

Now let us be a bit more hands on. In this section we will take a look at how to add/edit/delete objects using the Configure.
There are sometimes many ways to do things in OP5 Monitor but we will only show a few examples.
In the subsections to Managing objects we will assume that you start from the main page of Configure.

![](attachments/16482396/21300106.png)

# 
Before you start

## Add new

Every time you comes to a page where you can handle an object you will have the **Add new...** dialog ready for you to add a new object.

## Configuration files

Every object is placed in a configuration file. You may change what file the object is placed in at the bottom of every configuration page. This is normally not necessary and only used in special cases.

## Help

In the guides we will only describe the directive that are differ from the default value. Click the **help icon**

## Templates

Because handling templates is the same for all kind of templates, only the directives differ, we will only add a template in Contacts.

# Contacts

### Adding a contact template

Before we start to add any new contacts we will create a contact template to use with the contact in the next section. In this guide we only describes the directive we will not use the default value in.

### To add a contact template

-   -   -   Click **Contact templates**. 
        -   Give the contact template a name
            ![](attachments/16482396/21300172.png)
        -   Change **can\_submit\_commands** to yes.
             ![](attachments/16482396/21300181.png)  
            This gives this the user connected to this contact the possibility to execute commands like acknowledge problems etc.

-   -   -   Click **Submit**.
        -   Click **Save**.

## Adding a contact

### To add a contact

-   -   -   Click **Contacts** on the main page.
        -   Use the template on call template we created in Adding a contact template. ![](attachments/16482396/21300219.png) .
        -   Type in a contact\_name
            ![](attachments/16482396/21300201.png)
        -   Type in an alias
             ![](attachments/16482396/21300160.png)
        -   Type in the email address
             ![](attachments/16482396/21300167.png)
        -   Click **Submit**.
        -   If you want to create access check the "Configure access rights for this contact" box, otherwise save changes
            ![](attachments/16482396/21300156.png)
        -   When Configuring access right for this contact select the access rights the contact should have, after that save the changes.
            ![](attachments/16482396/21300108.png)

## Modify a contact

### To modify a contact

-   -   -   Click **Contacts** on the main page.
        -   Choose the contact you like to modify in the drop down list.
            ![](attachments/16482396/21300109.png)
        -   Click **Go**.
        -   In the view you will get only directives differ from the template will be shown. To change the other directives click **Advanced**.
        -   Make your modifications and click **Submit**.
        -   Click **Save**.

## Delete a contact

-   -   -   Click **Contacts** on the main page.
        -   Choose the contact you like to modify in the drop down list.
            ![](attachments/16482396/21300109.png)
        -   Click **Go**.
        -   Click on **Delete**.
            ![](attachments/16482396/21300116.png)
        -   Click **Save**.

# Hosts

There are many ways to add a host. A host can be added by

-   -   -   **Host Wizard**
        -   **new host** option
        -   a **network scan**
        -   cloning of a host
        -   using a profile

In this guide we only describes the directive we will not use the default value in.

## Adding a host with new host option

### To add a new hosts using the new host option - Part 1

-   -   -   Click** Hosts** on the main page.
        -   Type in a host\_name.
             ![](attachments/16482396/21300199.png)
        -   Type in an alias.
             ![](attachments/16482396/21300193.png)
        -   Type in the address to the host, IP address is mostly the best choice.
             ![](attachments/16482396/21300218.png)
        -   We assume this is a Microsoft windows server and that NSClient++ has been installed. Check for the following service checks.

            When using WMI a administrators account must be selected. It is also possible to create a user with less privileges, see how-to https://kb.op5.com/x/K4IK

        -   ![](attachments/16482396/21300216.png)
        -   Click host logo to set the icon that will be displayed for this host in lists and maps.
            ![](attachments/16482396/21300143.png) 
        -   Click the icon you like to use.
        -   Click **Add services**.
            ![](attachments/16482396/21300200.png)

### To add a new host using the new host option - Part 2

-   -   -   Leave the initial settings All new services will inherit the Initial Service Settings. If you choose not to enter a value for one or more required variable, those variables must be set in the selected template.
             as it is and scroll down to the services.
        -   The scan has found out that NSClient++ is installed plus two other services that can be added to this host.
            ![](attachments/16482396/21300119.png) 
        -   Check Select All to add all services found or select the one you like to add for this host.
        -   Click **Continue to step 3**.
        -   Now either click the host or service links or click **Save**.
            ![](attachments/16482396/21300120.png)

## Adding hosts with network scan

Network ranges can be specified in a very free form. Each of the four parts of the IP-address may contain any combination of comma-separated numbers, 'from-to' ranges and single numbers, as such: `10.1,2.0,4-10.1-50`.
 You can specify multiple ranges, separated by spaces, if you like.

### To add hosts with network scan

-   -   -   Click **Hosts** on the main page.
        -   Click **Network scan**.
            ![](attachments/16482396/21300121.png)
        -   Fill in the desired network range. We will scan for hosts in the range from `172.27.86.8 - 172.27.86.97`
             ![](attachments/16482396/21300226.png) .
        -   Click **Scan Ranges**.
        -   In this case we found Only hosts that aren't previously configured will be listed
             three hosts.
            ![](attachments/16482396/21300122.png)
        -   Repeat To add a new hosts using the new host option - Part 1 for each host, except for the last step. If here is one or more host you do not like to add choose **No** in **Add this host?** When you are finished click **Scan hosts for services**.
        -   Repeat To add a new host using the new host option - Part 2 for each host, except for the last step.When you are finished click **Continue to step 3**
        -   Click **Save**.

## Modifying a host

### To modify a host

-   -   -   On the start page choose the host you like to modify in the drop down list.
            ![](attachments/16482396/21300112.png)
        -   Click **Go**.
        -   In the view you will get only directives differ from the template will be shown. To change the other directives click **Advanced**.
            ![](attachments/16482396/21300196.png)
        -   Make your modifications and click **Submit.**
        -   Click **Save**.

 

## Deleting a host

### To modify a host

-   -   -   On the start page choose the host you like to delete in the drop down list.
            ![](attachments/16482396/21300112.png)
        -   Click **Go**.
        -   Click **Delete**.
             ![](attachments/16482396/21300198.png)
        -   Click **Delete all affected objects**.
        -   Click **Save**.

## Renaming objects

When renaming a host or service in the web GUI it will only rename the object and will not rename the objects name in log-files, graphs or report data in the database, meaning that the history logs for the object is lost.
 To rename the object name in log-files as well a program needs to be run manually. If this is not done the object will lose its alert history.

Renaming objects in the configuration files directly is **not** supported. It must be done via the configuration interface. This is due to that the rename application needs a change log to track the changes which is only created via the configuration interface.

Follow the guideline below to rename the objects throughout the system.

1.  Log in as root via SSH to your OP5 Monitor server
2.  Stop the monitoring service
3.  Make sure you save a backup
    \# op5-backup
4.  Execute the rename program
5.  Start the monitoring service again

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# mon stop
# su - monitor
$ /opt/monitor/op5/merlin/rename --rename-all
$ exit
# mon start
```

If there is a lot of historical data this program can take a while to execute and during this time the OP5 Monitor service will not be running.

Note that this does not work on schedule downtime objects. If a host is renamed that has a scheduled downtime the scheduled downtime will be removed and needs to be re-configured.

 

Network autoscan

It might get handy to let OP5 Monitor scan and notify you if there are any new hosts on a particular network range.
 The network autoscan function will

-   -   scan certain range for new hosts
    -   notify you when new are found
    -   be executed every night by cron on the OP5 Monitor server.

        No host will be automatically added. The network autoscan function will only find the hosts for you.

## Adding a new autoscan configuration

You may add as many autoscan configuration as you wish. When adding a your network range you may use the same syntax as when you manually scans a network from the Add new host wizard.

### To add a new autoscan configuration

 

-   -   -   Click **Configure** in the main menu.
        -   Click **Network Autoscan**.
        -   Fill in the **New scan** form
            ![](attachments/16482396/21300123.png)
        -   **Name**: The identifier of this autoscan configuration
        -   **IP Range**: In this case a complete C net.
        -   **Description**
        -   **Activate**: Make this autoscan configuration active and in use.
        -   Click **Save**.

## Adding a host to blacklist

In certain ranges you are scanning with the network autoscan there might be hosts you do not want to include in the result. Then you should add that host or hosts to the blacklist.

### To add a host to the blacklist

-   -   -   Click **Configure** in the main menu.
        -   Click **Network Autoscan**.
        -   Add a host (IP address) in the **Host** field
            ![](attachments/16482396/21300124.png)
        -   Click **Add**.

## The result

After the networks scan has been executed a small result will be shown in the upper left corner of the OP5 Monitor GUI
 ![](attachments/16482396/21300230.png)
 To add the hosts that has been found you only need to click on the text to the right of the icon. You will then come to the Add new host wizard the same as when you have done a manual network scan.

# Services

 Services can be added in a few different ways in Configure. You may add a service by using

-   -   -   **add service for this host**
        -   **scan host for network services**
        -   **scan host for snmp interfaces**
        -   **scan host for windows services with agent**
        -   **scan host for windows services using WMI**

We will take a look at the **add service for this host.**
 In this guide we only describes the directive we will not use the default value in.
 The default service template will used.

## Adding a service

### To add a service using add service for this host

-   -   -   On the start page choose the host you like to add a new service to in the drop down list.
            ![](attachments/16482396/21300112.png)
        -   Click **Go**.
        -   Click **Services for host...**.under related items menu to the right.
            ![](attachments/16482396/21300130.png)
            The add new service pages is shown.
        -   Type in a service\_description.
            ![](attachments/16482396/21300149.png)
        -   We will use the check\_nt\_cpuload command for this service.Type in as many characters you need in the filter by regular expression field until the command shows up.
            ![](attachments/16482396/21300135.png)
        -   Click **Syntax help** to see what arguments are needed for this command.
            ![](attachments/16482396/21300131.png)
            You can see that we have a macro called **\$ARG1\$**. This is the first, and in this case the only, argument we need to give to this command.
        -   Click **Syntax help** again to hide the help text.
        -   Type in the argument If more than one the shall be separated by a ! like this: argone!argtwo..
             ![](attachments/16482396/21300177.png)
        -   Click **Submit**.
        -   Click the **Save** icon.

If the arguments include an exclamation mark "!" this has to be escaped with an back slash (). Example: username!crypticpassword!!warning!critical
 This will out put "crypticpassword!"

## Modifying a service

### To modify a service

-   -   -   On the start page choose the host you like to modify a service on in the drop down list.
            ![](attachments/16482396/21300112.png)
        -   Click **Go**.
        -   Click **Services for host ...** .
             ![](attachments/16482396/21300221.png)
        -   Choose the service you like to modify in the drop down list.
            ![](attachments/16482396/21300113.png)
        -   Click **Go**.
        -   In the view you will get only directives differ from the template will be shown. To change the other directives click **Advanced**.
             ![](attachments/16482396/21300229.png)
        -   Make your modifications and click **Submit**.
        -   Click **Save**.

## Test this check

**Test this check** makes it possible for you to test the service you added or modified before you save the new configuration and reload monitor. This is a nice way to make sure the service works as it is supposed to.
 In the guide below we will work with the service created in Adding a service.

### To test a check

-   -   -   Pick up the service you like to test as it is done in Modifying a service.
        -   Click **Test this check**, at the bottom of the page.
            ![](attachments/16482396/21300183.png)
        -   The output looks like the one below. If you get any errors it will be shown here in the output
            ![](attachments/16482396/21300174.png)
        -   Click **Hide check** to hide the output.

### To test a hostgroup check

-   Pick up the service you like to test as it is done in Modifying a service.
-   Select the host that you would like the test to run on from the drop down menu.
    ![](attachments/16482396/21300136.png) 
-   Click **Test this check**, at the bottom of the page.
    ![](attachments/16482396/21300183.png)
-   The output looks like the one below. If you get any errors it will be shown here in the output
    ![](attachments/16482396/21300174.png)
-   Click **Hide check** to hide the output.

## Deleting a service

### To delete a service

-   -   -   On the start page choose the host you like to delete a service from in the drop down list.
            ![](attachments/16482396/21300112.png)
        -   Click **Go**.
        -   Click **Services for host ...** .
             ![](attachments/16482396/21300221.png)
        -   Choose the service you like to delete in the drop down list.
            ![](attachments/16482396/21300113.png)
        -   Click **Delete**.
             ![](attachments/16482396/21300148.png)
        -   Click **Save**.

## Scanning host for network services

When you [added your host](#Managingobjects-to-add-part1) you had the opportunity to add services found during the scan for network services. This scan function can also be reached afterwords.

### To scan a host for network services

-   -   -   Open up the host, in **Configure**, you like to add new services on.
        -   Click **Scan host for network services**.
        -   Select the new services found and click **Continue to step 3**.
        -   Click either the host or service link to go back to the place where you started.
        -   Click **Save**.

**Additional information**: In a distributed environment a selectbox will appear when hovering over the menu item "Scan host for network services" where you can select from which OP5 Monitor system that should preform the scan. ![](attachments/16482396/21300220.png)

## Scanning a host for snmp interfaces

In many times when you are about to monitor a switch or a router you need to setup a lot of services. It is hard work and takes a lot of time to add them one by one.
 Instead of adding all interface services one by one you should use the scan for snmp interfaces function.

### To add snmp interfaces

-   -   -   Open up the host, in **Configure**, you like to add new services on.
        -   Click **Scan host for SNMP interfaces**.
        -   Set the SNMP community.
        -   Chose SNMP version.
        -   Click **Scan host**.
            ![](attachments/16482396/21300125.png)
        -   Select the services you like to add.
        -   Click either the host or the service link to get back.
        -   Click **Add selected services**.
        -   Click **Save**.

# Scanning host for windows services

There are two ways to scan a windows host for services:

-   -   Using the windows agent NSclient++
    -   Using WMI, Windows Management Instrumentation

The following sections will describe how to accomplish this using the different techniques.

## Scan for services using agent

Adding a service that checks a windows services is many times harder than you think. You need to

-   -   -   have access to the windows server
        -   know the exact name of the windows service

With OP5 Monitor you do not need to do anything more than make sure the latest agent (NSClient++) is installed and follow the next few steps.

### To add windows services

-   -   -   Open up the host, in **Configure**, you like to add new services on.
        -   Click **Scan host for Windows Services**.
        -   Choose which server to preform the scan:
             ![](attachments/16482396/21300145.png)
        -   Select the Windows Services you like to add as a new service in OP5 Monitor.
            ![](attachments/16482396/21300134.png)
        -   Give the new service a **Service description**.
        -   Click **Add Selected Services**.
        -   Click either the service link or the **Scan for more service** button.
        -   Click **Save**.

## Scan for service using WMI

Scan for services using Windows Management Instrumentation has a number of dependencies to be able to work:

-   -   -   WMI enabled on the windows server
        -   User account on the windows server with sufficient privileges

 There are two ways to scan for WMI on a windows host:

-   -   -   When adding a new host
        -   Scanning a existing host

### Scanning for WMI when adding a new host

To scan a host for WMI-counters and services upon adding the host to your OP5 Monitor configuration as partly described in: Adding a host with new host option.
 To scan for WMI counters when adding a new host:

-   -   -   Select **Configure** in the main menu
        -   Click on **New Hosts**
        -   Enter the information about the host
        -   Select the checkbox **Add WMI
            ** ![](attachments/16482396/21300224.png)
        -   Enter username and password
        -   Press **Add Services
            ** ![](attachments/16482396/21300194.png)
        -   Select the services you wish to add from the list
             ![](attachments/16482396/21300168.png) :

 

-   -   -   Press **Finish
            ** ![](attachments/16482396/21300166.png) at the end of the page.

The host is added and you can save your configuration.
 ![](attachments/16482396/21300164.png)

-   -   -   Press **Save** in the top right corner
            ![](attachments/16482396/21300214.png)
        -   Review your changes then by clicking on **More info** press **Save objects I have change**d
            ![](attachments/16482396/21300165.png)

After this the configuration will be saved and i final preflight configuration check has been performed.
 ![](attachments/16482396/21300204.png)
 Your configuration is saved and the host and its services are ready to be monitored.
![](attachments/16482396/21300140.png)

# Custom Variables

Custom variables can be used to store custom information for hosts, services and contacts in the configuration. These variables can be used as a macro in command arguments and notifications for example.
 All custom variables will automatically get a underscore "\_" as a prefix to prevent name collisions with the standard variables.
 The custom variable will also automatically be converted to upper case.
 In order to prevent name collision among custom variables from different object types, Naemon prepends "\_HOST", "\_SERVICE", or "\_CONTACT" to the beginning of custom host, service, or contact variables, respectively, in macro and environment variable names.
 These variables can be used as macros in same way as the standards macros in OP5 Monitor.
 When using a custom variable as a macro a "\$"-sign is always used before and after the variable name.

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p><strong>Entered Name</strong></p>
<p><strong>Variable name</strong></p>
<p><strong>Macro name</strong></p></td>
<td align="left"><p>snmp_community</p>
<p>_SNMP_COMMUNITY</p>
<p>$_SNMP_COMMUNITY$</p></td>
<td align="left"><p>location</p>
<p>_LOCATION</p>
<p>$_LOCATION$</p></td>
</tr>
</tbody>
</table>

 

## Creating a new custom variable

Go to the configuration for a host, service or contact and click on **add custom variable**.
![](attachments/16482396/21300209.png)
 Enter a variable name and the value of the variable. Note that the prefix underscore and conversion to upper case is done automatically.
 ![](attachments/16482396/21300190.png)
 Click on **submit** and save the configuration.

## Example

Instead of using the SNMP community name hardcoded in the check command or in the command arguments in the service check we will create a custom variable that we will use as a macro in the command arguments.
 In this example we will move the SNMP community name on a traffic check on a switch port from being in the command arguments to a custom variable.
 First we create a custom variable on a switch traffic check, see Creating a new custom variable.
 Name the variable: `snmp_community` (the prefix and upper case conversion will be done automatically).
 Enter the name of your SNMP community as a value. Let's say for this example that the community name is "qwerty"
 Change the command argument of the command argument from "`qwerty!2!100mbit!70!90`" to "`$_SERVICESNMP_COMMUNITY$!2!100mbit!70!90`"

![](attachments/16482396/21300105.png)
 Click on **submit** and save the configuration.

# Dynamic Button

The dynamic button is a customizable button which any script can be added to.
 If defined, a link in the service information page will appear under "Service Commands" on the service ext info page.

## Configuration

To configure the dynamic button two custom variables has to be created on the service which the button should be added to.
 The first one is the command line and the second one is the permissions.
 The prefix \_OP5 symbolizes that this is a dynamic button variable. If an H is added to the prefix (\_OP5H) the custom variables will not be visible in the Service State Information table.
 **`_OP5H__ACTION__NAME`**
**`_OP5H__ACCESS__NAME`**

Note that there are two underscores!

### Action

The action has the variable name \_**`OP5H__ACTION__NAME`**
 The value of the action is the path to the script that should be executed.
 The name of the button is set by replacing "NAME" in the variable name. When using spaces in the name, this should be replaced by one underscore.
 **Example:**
 To name the dynamic button "Restart Service" and it will execute the script /opt/plugins/custom/restart\_service.sh. The variable name should be:
 **Variable name:**`_OP5H__ACTION__RESTART_SERVICE`
 **Value:**`/opt/plugins/custom/restart_service.sh`

### Access

The `OP5HACCESS_NAME` sets who will be able to use the dynamic button. This is set on contact-groups only.
 If a user is not in a group that is specified in the access variable the button will not be visible for the user.
 The access variable name must have the same name as the action name.
 **Example**
 If you want to give access to the "Restart Service" action to the support-group and windowsadmins groups the setup should look like this:
 **Variable name:** \_`OP5H__ACCESS__RESTART_SERVCE`
 **Value:** `support-group,windows-admins`

# Escalations

Escalations let you configure escalation of notifications for this host. The idea is that if you have a really important host you can send the first notification to the default contact group in order for them to solve the problem. If the problem is not solved in lets say 30 minutes you can send the notification to a broader range of contacts, as the name implies, escalate the issue.

Host and service escalations works exactly in the same way so we will only take a look at host escalations from now on.

## Adding a host escalation

In this guide we will add a small escalation chain that does the following

-   -   -   First notification is sent to the support-group
        -   After 10 minutes the second (the last one) is sent to the sysadmins group.

### To add a host escalation

-   -   -   On the **Edit Host** page, choose the host you like to add an escalation to in the drop down list.
            ![](attachments/16482396/21300112.png)
        -   Click **Go**.
        -   Click **Escalations**.
            ![](attachments/16482396/21300192.png)
        -   Add the escalation number one.
        -   Choose the contact group that shall have the notification.
            ![](attachments/16482396/21300110.png)
        -   Set the start number in the escalation chain.
             ![](attachments/16482396/21300151.png)
        -   Set the end number in the escalation chain If the start number is 1 and the end number is two it means that the first and the second notification will be handled by this escalation.
             . ![](attachments/16482396/21300173.png)
        -   Set the notification interval which is the number of minutes to wait to the next notification.
             ![](attachments/16482396/21300155.png)
        -   Choose the time period when this escalation will be in use.
            ![](attachments/16482396/21300142.png)
        -   Choose what states this escalation will be valid for.
            ![](attachments/16482396/21300132.png)
            In this case we do not use the escalation for unreachable or recovery which means that unreachable and recovery notifications will be sent to the contact group set on the host.
        -   Click **Submit**.
        -   Choose Add new host escalation
            ![](attachments/16482396/21300127.png)
        -   Click **Go**.
        -   Add the escalation number two.
        -   Choose the contact group that shall have the notification.
            ![](attachments/16482396/21300111.png)
        -   Set the start number in the escalation chain.
             ![](attachments/16482396/21300202.png)
        -   Set the end number in the escalation chain We have set the first notification and the last notification to 2 because this escalation will only be used once.
             . ![](attachments/16482396/21300223.png)
        -   Set the notification interval which is the number of minutes to wait to the next notification.
             ![](attachments/16482396/21300186.png) The escalation interval is set to 0 because there will be no more escalations when this one is done.

-   -   -   Choose the time period when this escalation will be in use.
            ![](attachments/16482396/21300217.png)
        -   Choose what states this escalation will be valid for.
            ![](attachments/16482396/21300132.png)
            In this case we do not use the escalation for unreachable or recovery which means that unreachable and recovery notifications will be sent to the contact group set on the host.
        -   Click **Submit**.
        -   Click **Save**.

## Modifying a host escalation

### To modify a host escalation

-   -   -   On the start page choose the host you like to modify an escalation on in the drop down list.
            ![](attachments/16482396/21300112.png)
        -   Click **Go**.
        -   Click **Escalations**.
            ![](attachments/16482396/21300169.png)
        -   Choose the escalation you like to modify.
             ![](attachments/16482396/21300197.png)
        -   Click **Go**.
        -   Make the modifications you like to do and click **Submit**.
        -   Click **Save**.

## Deleting a host escalation

### To delete a host escalation

-   -   -   On the start page choose the host you like to delete an escalation from in the drop down list.
            ![](attachments/16482396/21300112.png)
        -   Click **Go**.
        -   Click **Escalations**.
             ![](attachments/16482396/21300171.png)
        -   Choose the escalation you like to modify.
            ![](attachments/16482396/21300231.png)
        -   Click **Go**.
        -   Click **Delete**.
             ![](attachments/16482396/21300198.png)
        -   Click **Save**.

# Access rights and contacts

To be able to login to OP5 Monitor you need to have a user, described in Local users on page Main Objects. But you need to have a contact, described in Contacts on page Main Objects, to be able to receive notifications and in some cases even be able to see any hosts or services.
 By connecting access rights to a contact you will be able to login and get notifications with the user created in access rights.
 So basically what you need to do is to configure a new contact. Add the contact to an existing contact group or create a new contact group specific for the new contact. If you created a new contact group make sure to add the contact group for the hosts and services that you want to make available in the customized view.
 Add new access rights and connect it to the contact you created earlier.

## Connecting access rights to contacts

### To connect access rights to a contact

-   -   -   Configure a new contact.
        -   Add the contact to an existing contactgroup or create a new contactgroup specific for the new contact. If you created a new contactgroup make sure to add the contact group for the hosts and services that you want to make available in the customized view.
        -   Configure a user in access rights with the exact same name as the contact you created.
        -   Set the options for the new access right.When selecting options do not use the last four options, authorized for all. By doing this the new user will only see the hosts and services that uses the contactgroup that he is a member of.

# Management packs

A management pack is essantially a group of services connected to a hostgroup with the possibility to add custom variables. These are then used by the Host Wizard.
 The benefit with using management packs is that the monitoring will be more homogenous.
 The picture below shows how management packs integrates into OP5 Monitor.
 ![](attachments/16482396/21300144.png)

## Creating management packs

To create a management pack a hostgroup must be created and the services that should be included in the management pack should be added to that hostgroup. See Services on Host groups on page Groups for more information.
 After the hostgroup with services has been created the hostgroup can be converted into a management pack.
 To create a new management pack from a hostgroup go to **Management Packs** in the configuration.
![](attachments/16482396/21300178.png)

-   -   -   Enter a name for the management pack.
        -   Select whitch hostgroup that should be used for the management pack.
        -   Select an icon (a larger icon looks better in the host wizard).
        -   Enter a description.

It is also possible to add custom variables, these can be used for information that needs to be entered when using the host wizard. Such as username, password and SNMP community names.
 ![](attachments/16482396/21300188.png)
 In this example we create a management pack for HP Servers with one custom variable for SNMP community name.
 Click on **Submit** to save the management pack.

## Group in Group with Management Packs

It is possible to use the group in group with management packs. This works in the same way as it does for normal hostgroups.

### Example

The hostgroup fruits includes the hostgroup '`apples`'.
 If a management pack i associated with '`fruits`' will the host be added to the hostgroup '`fruits`' and it will get all the services that is on the hostgroup '`fruits`', but it will not be affected by the '`apples`' hostgroup.
 If a management pack is associated with apples the host will be added to the hostgroup apples and get all the services that is in the hostgroup '`apples`' AND all the services that is in the hostgroup '`fruits`'.
 More concrete; A hostgroup '`linux`' is created with the check '`check_ssh_cpu`' A hostgroup '`generic`' is created with the check '`check_ping`'
 Management pack '`generic server'` is associated with the hostgroup '`generic`'. Hosts that are added with the management pack '`generic server`' will get the '`check_ping`' service.
 Mangement pack '`linux servers`' is associated with the hostgroup '`linux`'. Hosts added with the '`linux servers`' will get both the '`check_ssh_cpu`' and the '`check_ping`' checks.

## Activate Management Packs

Management packs that is not created by the user, provided by OP5 or a third party, needs to be activeted.
 To activate a management pack go to **Mangement Pack Management** in the configuration.
 ![](attachments/16482396/21300187.png)
 Click on **Activate** to activate a management pack.
![](attachments/16482396/21300208.png)
 **Force Activate** will override any management pack with the same name.

## Import Management Packs

To import a management pack from a json-file go to Management Pack Management.
![](attachments/16482396/21300176.png)
 Click on **Choose File** to select the json-file that should be imported.
![](attachments/16482396/21300154.png)
 Click on **Upload json file** to import the management pack.

## Export Management Packs

Export management packs makes it possible to share your management pack with others or upload it to another OP5 Monitor server.
 Go to Mangement Pack Mangement under configuration.
 ![](attachments/16482396/21300153.png)
 Click on Export on the management pack to export this to a json-file. The file will be downloaded to you computer.
![](attachments/16482396/21300212.png)

