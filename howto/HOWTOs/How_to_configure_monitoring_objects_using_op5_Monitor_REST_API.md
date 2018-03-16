# How to configure monitoring objects using OP5 Monitor REST API

Version

This article was written for version 7.2 of OP5 Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by OP5 Support.

 

-   [About the document](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Aboutthedocument)
-   [About the examples](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Abouttheexamples)
-   [Changes](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Changes)
    -   [View changes](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Viewchanges)
    -   [Reset/delete changes](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Reset/deletechanges)
    -   [Save](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Save)
-   [Add a host](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Addahost)
-   [Add a service](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Addaservice)
-   [Add a host group or service group](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Addahostgrouporservicegroup)
-   [Add a template](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Addatemplate)
-   [Add a contact](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Addacontact)
-   [Add a contact group](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Addacontactgroup)
-   [Change settings on an object](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Changesettingsonanobject)
-   [Configuration errors](#Howtoconfiguremonitoringobjectsusingop5MonitorRESTAPI-Configurationerrors)

# About the document

In this documentation I will show you how to work with objects configuration through our REST-API. The examples are made with the command line command '`curl`'. Of course this can be made with script languages like python, perl etc as well but that is not covered here.

If you have a locally created SSL certificate for the monitor webserver you need to use '`--insecure`' so '`curl`' does not try to verify the certificate.

 

As you can see in the document almost all settings for the objects have the same name as they do in the GUI. For more information about the specific object types please look in the reference manual:
<https://your-monitor-server/api/help/config/>

# About the examples

In the examples below the following variables will be used. This so you can easily change them and try the command lines directly.

    MONITOR_USER=monitor
    MONITOR_PASSWORD=monitor
    MONITOR_SERVER=your-monitor-server

The result out put has been "prettified" to make it easier to read. When running the commands you will see that the json output will be shown as one long line. If you like to have the result in a more readable way you can add format=xml at the end of the URL in the command examples, like this:

    https://$MONITOR_SERVER/api/config/service?format=xml

Getting started

Before you start using the REST API you need to make sure you have a user which can access the REST API.

More about this can be found in "[How to use OP5 Monitor REST API](How_to_use_op5_Monitor_REST_API)".

# Changes

When it comes to changes all calls should point to:

<https://your-monitor-server/api/config/change>

Depending on what kind of request you send to the API you will get different functions. With the 'curl' command it's the -X option that set request type. The choices are shown in the reference manual:
<https://your-monitor-server/api/help/>

## [View changes](https://your-monitor-server/api/help/)

To view the changes you have made send a GET request to /api/config/change:

    $ curl -H 'content-type: application/json' -X GET -u "$MONITOR_USER:$MONITOR_PASSWORD" "https://$MONITOR_SERVER/api/config/change"

## Reset/delete changes

If you for some reasons decide that you do not want to keep the changes not exported to the configuration files then you can delete them with:

    $ curl -H 'content-type: application/json' -X DELETE -u "$MONITOR_USER:$MONITOR_PASSWORD" "https://$MONITOR_SERVER/api/config/change"

**The result:**

    "Changes reverted"

 

This is the same as if you clicked "Undo" in the GUI.

## Save

When you're satisfied with your changes just send a POST like this to save and export the changes to the configuration files:

    $ curl -H 'content-type: application/json' -X POST -u "$MONITOR_USER:$MONITOR_PASSWORD" "https://$MONITOR_SERVER/api/config/change"

# Add a host

When adding a host you will only add the host object. No services are added here that needs to be done service by service after the host has been added.
Here is an example of how to add a new host:

    $ curl -H 'content-type: application/json' -X POST -d '{ "file_id": "etc/hosts.cfg", "host_name": "test-01", "max_check_attempts": "3", "notification_interval": "5", "notification_options": ["d","r"], "notification_period": "24x7", "template": "default-host-template"}' "https://$MONITOR_SERVER/api/config/host" -u "$MONITOR_USER:$MONITOR_PASSWORD"

The result:

    {
        "2d_coords": "",
        "_DEFAULT_HOST_TEMPLATE_VAR_1": "1",
        "_DEFAULT_HOST_TEMPLATE_VAR_2": "2",
        "action_url": "",
        "active_checks_enabled": true,
        "address": "test-01",
        "alias": "",
        "check_command": "check-host-alive",
        "check_command_args": "",
        "check_freshness": false,
        "check_interval": 5,
        "check_period": "24x7",
        "children": [],
        "contact_groups": [],
        "contacts": [],
        "display_name": "",
        "event_handler": "",
        "event_handler_args": "",
        "event_handler_enabled": true,
        "file_id": "etc/hosts.cfg",
        "first_notification_delay": "",
        "flap_detection_enabled": false,
        "flap_detection_options": [],
        "freshness_threshold": "",
        "high_flap_threshold": "",
        "host_name": "test-101",
        "hostgroups": [],
        "icon_image": "",
        "icon_image_alt": "",
        "low_flap_threshold": "",
        "max_check_attempts": 3,
        "notes": "",
        "notes_url": "",
        "notification_interval": 0,
        "notification_options": [
            "d",
            "f",
            "r",
            "s",
            "u"
        ],
        "notification_period": "24x7",
        "notifications_enabled": true,
        "obsess": false,
        "obsess_over_host": false,
        "parents": [],
        "passive_checks_enabled": true,
        "process_perf_data": true,
        "register": true,
        "retain_nonstatus_information": true,
        "retain_status_information": true,
        "retry_interval": 0,
        "stalking_options": [
            "n"
        ],
        "statusmap_image": "",
        "template": "default-host-template"
    }

 

There are a couple of settings which are required. This means that you need to set them either explicitly on the object or in the template. If you have setup your template with:

-   max\_check\_attempts
-   notification\_interval
-   notification\_options
-   notification\_period

Then you can skip them in the add-host command and just execute it like this:

    $ curl -H 'content-type: application/json' -d '{ "file_id": "etc/hosts.cfg", "host_name": "test-02", "template": "default-host-template"}' "https://$MONITOR_SERVER/api/config/host" -u "$MONITOR_USER:$MONITOR_PASSWORD"

The result will be the same as above. The default values will be added where you set your own in the first example.

The rest of the settings and what type to use can be found here:
<https://your-monitor-server/api/help/config/host>

# Add a service

Adding a service is more or less the same thing as adding a host. All required fields needs to be set but they can be set either on the service object or in the service template used.

Here is an example:
You need to know what host you want to add the service to. Let's call the host "test-01".

    $ curl -H 'content-type: application/json' -d '{"file_id": "etc/services.cfg", "check_command": "check_ping", "check_command_args": "100,20%!500,60%", "check_interval": "5", "check_period": "24x7", "host_name": "test-01", "max_check_attempts": "3", "notification_interval": "0", "notification_options": ["c", "w", "u", "r"], "notification_period": "24x7", "retry_interval": "1", "service_description": "PING", "template": "default-service"}' "https://$MONITOR_SERVER/api/config/service" -u "$MONITOR_USER:$MONITOR_PASSWORD"

The result:

    {
        "action_url": "",
        "active_checks_enabled": true,
        "check_command": "check_ping",
        "check_command_args": "100,20%!500,60%",
        "check_freshness": false,
        "check_interval": 5,
        "check_period": "24x7",
        "contact_groups": [],
        "contacts": [],
        "display_name": "",
        "event_handler": "",
        "event_handler_args": "",
        "event_handler_enabled": true,
        "file_id": "etc/services.cfg",
        "first_notification_delay": "",
        "flap_detection_enabled": false,
        "flap_detection_options": [
            "c",
            "o",
            "u",
            "w"
        ],
        "freshness_threshold": "",
        "high_flap_threshold": "",
        "host_name": "test-01",
        "hostgroup_name": "",
        "icon_image": "",
        "icon_image_alt": "",
        "is_volatile": false,
        "low_flap_threshold": "",
        "max_check_attempts": 3,
        "notes": "",
        "notes_url": "",
        "notification_interval": 0,
        "notification_options": [
            "c",
            "r",
            "u",
            "w"
        ],
        "notification_period": "24x7",
        "notifications_enabled": true,
        "obsess": true,
        "obsess_over_service": true,
        "parallelize_check": true,
        "passive_checks_enabled": true,
        "process_perf_data": true,
        "register": true,
        "retain_nonstatus_information": true,
        "retain_status_information": true,
        "retry_interval": 1,
        "service_description": "PING",
        "servicegroups": [],
        "stalking_options": [
            "n"
        ],
        "template": "default-service"
    }

 

If you have added the required settings in your template you could use a much shorter and simpler command line like this:

    $ curl -H 'content-type: application/json' -d '{"file_id": "etc/services.cfg", "check_command": "check_ping", "check_command_args": "100,20%!500,60%", "host_name": "test-01", "service_description": "PING", "template": "default-service"}' "https://$MONITOR_SERVER/api/config/service" -u "$MONITOR_USER:$MONITOR_PASSWORD"
     

The result will be the same as above. The default values will be added where you set your own in the first example.

# Add a host group or service group

A host group can be added without any members but it might be a good idea to do that directly from start. So to add a new host group with two members, I'll use test-01 and test-02 as member, you do like this:

    $ curl -H 'content-type: application/json' -d '{"file_id": "etc/hostgroups.cfg", "hostgroup_name": "test_hostgroup-01", "members": ["test-01", "test-02"]}' "https://$MONITOR_SERVER/api/config/hostgroup" -u "$MONITOR_USER:$MONITOR_PASSWORD"

**The result:**

    {
        "action_url": "",
        "alias": "",
        "file_id": "etc/hostgroups.cfg",
        "hostgroup_members": [],
        "hostgroup_name": "test_hostgroup-01",
        "members": [
            "test-01",
            "test-02"
        ],
        "notes": "",
        "notes_url": "",
        "register": true
    }

 

The same goes for the service groups but with other options:

    $ curl -H 'content-type: application/json' -d '{"file_id": "etc/servicegroups.cfg", "servicegroup_name": "ping_services", "members": ["test-01;PING", "test-02;PING"]}' "https://$MONITOR_SERVER/api/config/servicegroup" -u "$MONITOR_USER:$MONITOR_PASSWORD"

**The result:**

    {
        "action_url": "",
        "alias": "",
        "file_id": "etc/servicegroups.cfg",
        "members": [
            "test-01;PING",
            "test-02;PING"
        ],
        "notes": "",
        "notes_url": "",
        "register": true,
        "servicegroup_members": [],
        "servicegroup_name": "ping_services"
    }

 

More details can be found in the reference manual:
<https://your-monitor-server/api/help/config/hostgroup>
<https://your-monitor-server/api/help/config/servicegroup>

# Add a template

The templates are actually host/service/contact objects that are not registred to be used as normal objects.
So adding a template is almost as adding a normal object of the same kind. The only big difference here is that the template only require one setting; "name"

Here is an example command for adding a new host template:

    $ curl -H 'content-type: application/json' -d '{"name": "test-host-template"}' "https://$MONITOR_SERVER/api/config/host_template" -u "$MONITOR_USER:$MONITOR_PASSWORD"

**The result:**

    {
        "2d_coords": "",
        "action_url": "",
        "active_checks_enabled": true,
        "address": "",
        "alias": "",
        "check_command": "check-host-alive",
        "check_command_args": "",
        "check_freshness": false,
        "check_interval": 5,
        "check_period": "24x7",
        "children": [],
        "contact_groups": [
            "support-group"
        ],
        "contacts": [],
        "display_name": "",
        "event_handler": "",
        "event_handler_args": "",
        "event_handler_enabled": true,
        "file_id": "etc/hosts.cfg",
        "first_notification_delay": "",
        "flap_detection_enabled": false,
        "flap_detection_options": [],
        "freshness_threshold": "",
        "high_flap_threshold": "",
        "hostgroups": [],
        "icon_image": "",
        "icon_image_alt": "",
        "low_flap_threshold": "",
        "max_check_attempts": 3,
        "name": "test-host-template",
        "notes": "",
        "notes_url": "",
        "notification_interval": 0,
        "notification_options": [
            "d",
            "f",
            "r",
            "s",
            "u"
        ],
        "notification_period": "24x7",
        "notifications_enabled": true,
        "obsess": false,
        "obsess_over_host": false,
        "parents": [],
        "passive_checks_enabled": true,
        "process_perf_data": true,
        "register": false,
        "retain_nonstatus_information": true,
        "retain_status_information": true,
        "retry_interval": 0,
        "stalking_options": [
            "n"
        ],
        "statusmap_image": "",
        "template": "default-host-template"
    }

 

The only thing you need to change is the path and of course use the correct settings for the objects. The paths:

-   Host templates: <https://your-monitor-server/api/config/host_template>
-   Service templates: <https://your-monitor-server/api/config/service_template>
-   Contact templates: <https://your-monitor-server/api/config/contact_template>

The settings are the same as for a normal object of the same type.

More about this:
<https://your-monitor-server/api/help/config/host_template>
<https://your-monitor-server/api/help/config/service_template>
<https://your-monitor-server/api/help/config/contact_template>

# Add a contact

Contacts have a few settings that are required. With all those settings included an example can look like this (adding contact-01 here):

    $ curl -H 'content-type: application/json' -d '{"file_id": "etc/contacts.cfg", "alias": "Contact 01", "contact_name": "contact-01", "host_notification_options": ["d","r"], "host_notification_period": "24x7", "service_notification_options": ["c", "w", "u", "r"], "service_notification_period": "24x7"}' "https://$MONITOR_SERVER/api/config/contact" -u "$MONITOR_USER:$MONITOR_PASSWORD"

**The result:**

 

    {
        "address1": "",
        "address2": "",
        "address3": "",
        "address4": "",
        "address5": "",
        "address6": "",
        "alias": "Contact 01",
        "can_submit_commands": true,
        "contact_name": "contact-01",
        "contactgroups": [],
        "email": "",
        "enable_access": "",
        "file_id": "etc/contacts.cfg",
        "host_notification_cmds": "host-notify",
        "host_notification_cmds_args": "",
        "host_notification_options": [
            "d",
            "r"
        ],
        "host_notification_period": "24x7",
        "host_notifications_enabled": true,
        "pager": "",
        "register": true,
        "retain_nonstatus_information": true,
        "retain_status_information": true,
        "service_notification_cmds": "service-notify",
        "service_notification_cmds_args": "",
        "service_notification_options": [
            "c",
            "r",
            "u",
            "w"
        ],
        "service_notification_period": "24x7",
        "service_notifications_enabled": true,
        "template": "default-contact"
    }

 

Most of the required settings as well as the others can be set in a contact template instead and then you do not need to set all the above on each single contact.

More details can be found in the reference manual:
<https://your-monitor-server/api/help/config/contacts>

# [Add a contact group](https://your-monitor-server/api/help/config/contacts)

A contact group can be added without any members but it might be a good idea to do that directly from start. So to add a new contact group with two members, I'll use contact-01 and contact-02 as member, you do like this:

    $ curl -H 'content-type: application/json' -d '{"file_id": "etc/contactgroups.cfg", "contactgroup_name": "test_contactgroup-01", "alias": "Test contact group 01", "members": ["contact-01", "contact-02"]}' "https://$MONITOR_SERVER/api/config/contactgroup" -u "$MONITOR_USER:$MONITOR_PASSWORD"

The result:

    {
        "alias": "Test contact group 01",
        "contactgroup_members": [],
        "contactgroup_name": "test_contactgroup-01",
        "file_id": "etc/contactgroups.cfg",
        "members": [
            "contact-01",
            "contact-02"
        ],
        "register": true
    }

 

Note that "alias" is required here.

More details can be found in the reference manual:
<https://your-monitor-server/api/help/config/contactgroup>

# [Change settings on an object](https://your-monitor-server/api/help/config/contactgroup)

When you change one or more settings on an object you need to send a PATCH request to the API. Then you set:
`-X PATCH`
You will also need to specify in the "path"/"url" what object you want to change the settings on.

Here is an example:
In the example we will change the name of one contact group. The group test\_contactgroup-01 will be renamed to contactgroup-01.

    $ curl -H 'content-type: application/json' -X PATCH -d '{"contactgroup_name": "contactgroup-01"}' "https://$MONITOR_SERVER/api/config/contactgroup/test_contactgroup-01" -u "$MONITOR_USER:$MONITOR_PASSWORD"

**The result:**

    {
        "alias": "Test contact group 01",
        "contactgroup_members": [],
        "contactgroup_name": "contactgroup-01",
        "file_id": "etc/contactgroups.cfg",
        "members": [
            "mk",
            "monitor"
        ],
        "register": true
    }

 

# Configuration errors

If you send in a malformed request to the API using json data the response form the server will be an error message formated as json data.

Let's say you have tried to change an object that does not exists. Then you will get the following error message:

    {
        "error": "Object not found",
        "full_error": "Object not found"
    }

 

This is error will be returned if you are not allowed to login:

    {
        "error": "Unauthorized",
        "full_error":"You need to login to access this page"
    }

 

 

