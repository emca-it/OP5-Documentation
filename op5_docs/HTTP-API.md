# HTTP-API

# About

OP5 Monitor comes with a REST API. It lets you configure, get status information, and get report data by issuing regular HTTP requests. The workflow should be familiar to anyone that has used a REST API:

-   You visit a URI;
-   This triggers the OP5 Monitor web server to get Naemon query handle or another aspect of OP5 to give or take information;
-   The web server replies with Monitor's results.

The response can be formatted as HTML, JSON, or XML.

For more information about the REST API go to [API help page](https://demo%40op5.com:MonitorDemo123@demo.op5.com/api/help). This page is also available within your installation at [https://{your.op5.monitor}/api/help/](https://your-op5-monitor/api/help/) , replacing "{your.OP5.monitor}" with your Monitor server's FQDN.

This document does not attempt to replace those pages, as they are kept updated with each API improvement. Instead we want this to give a better idea of how each subsection can help you, how to find what you need more quickly by understanding the subsections.

Note also that there is still a section for Status API. This has been obsolete since OP5 Monitor version 6.3, replaced by the Filter queries (which get their data more directly from the databases). We will remove this section in an upcoming release. 

**Table of Contents**

-   [About](#HTTP-API-About)
-   [HTTP Filter API](#HTTP-API-HTTPFilterAPI)
    -   [Filter](#HTTP-API-Filter)
    -   [Count](#HTTP-API-Count)
-   [HTTP Configuration API](#HTTP-API-HTTPConfigurationAPI)
-   [HTTP Command API](#HTTP-API-HTTPCommandAPI)
-   [HTTP Report API](#HTTP-API-HTTPReportAPI)
-   [HTTP Filter API](#HTTP-API-HTTPFilterAPI.1)
-   [Script Example](#HTTP-API-ScriptExample)
    -   [REST and LDAP](#HTTP-API-RESTandLDAP)

# HTTP Filter API

The filter API will allow you to fetch information and status from filters about hosts, services, traps, logs and much more. For more information about filters, please read the [Filters](Filters) chapter. If you are already familair with OP5 Listview syntax, then you can create filter queries with minimal character replacements: '%20' for space, for example.

There are two sections within the filter API: filter and count --

## Filter

By using filter you will get the whole list of object within the filter.

Example: To view hosts that are not OK --
`https://{your.op5.monitor}/api/filter/query?query=[hosts]%20state!=0&columns=name,state,acknowledged,has_been_checked` 

## Count

Count will return the count of objects in the filter search.

Example: To get a count of the objects using the same query as above --
`https://{your.op5.monitor}/api/filter/count?query=[hosts]%20state!=0&columns=name,state,acknowledged,has_been_checked` 

This is an example of how a query might look like, in this example we will fetch hosts that are down, not acknowledged and not in scheduled downtime
 https://demo.op5.com/api/filter/query?query=[hosts] state != 0 and acknowledged = 0 and scheduled\_downtime\_depth = 0

The documentation for filters can be found [here](https://demo%40op5.com:MonitorDemo123@demo.op5.com/api/help/filter) or in your op5 Monitor server at https://{your.op5.monitor}/api/help/filter

# HTTP Configuration API

The configure API is used to manipulate the object configuration used by op5 Monitor. It uses the same configuration database as the op5 Monitor Configuration tool does. Objects changed by the API will also be visible within the configuration GUI. You may use it to integrate OP5 Monitor with other third-party software.

The API help page for configuration can be found [here](https://demo%40op5.com:MonitorDemo123@demo.op5.com/api/help/config) or in your op5 Monitor server at https://{your.op5.monitor}/api/help/filter .

# HTTP Command API

The command section lets you submit the following commands to OP5 Monitor using the REST API. The API help page for commands can be found [here](https://demo%40op5.com:MonitorDemo123@demo.op5.com/api/help/command) or in your op5 Monitor server at https://{your.op5.monitor}/api/help/command .

# HTTP Report API

The report API can be used to retrieve report data in either XML or JSON format.

# HTTP Filter API

The filter API can be used to ether retrieve a list of objects from a filter or do a count of objects in a filter.

# Script Example

In this example we will create a new host called **my\_server** -- IP address **192.168.0.20** -- with one ping service. The OP5 server is called **op5-server**, the username is **joe**, and joe's password is **joespassword**. The page <https://op5monitor.example.com/api/help/config/host>, provides more detailed information on how to create a host.

This is what needs to be done as a PHP section, which can be placed directly into HTML as well. For Python calls, we will provide a related example in a future release:

**Joe pings my\_server**

``` {.php data-syntaxhighlighter-params="brush: php; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: php; gutter: false; theme: Confluence"}
<?php
$data = json_encode(array(
'address' => '192.168.0.20',
'alias' => 'My Server',
'host_name' => 'my_server'
));
$a_handle = curl_init('https://op5monitor.example.com/api/config/host');
curl_setopt($a_handle, CURLOPT_USERPWD, 'joe:joespassword');
curl_setopt($a_handle, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($a_handle, CURLOPT_POSTFIELDS, $data);
curl_setopt($a_handle, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
curl_setopt($a_handle, CURLOPT_SSL_VERIFYPEER, false);
$host = curl_exec($a_handle); 
$data = json_encode(array(
'check_command' => 'check_ping',
'service_description' => 'ping',
'host_name' => 'my_server'
));
$a_handle = curl_init('op5-server/api/config/service');
curl_setopt($a_handle, CURLOPT_USERPWD, 'joe:joespassword');
curl_setopt($a_handle, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($a_handle, CURLOPT_POSTFIELDS, $data);
curl_setopt($a_handle, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
curl_setopt($a_handle, CURLOPT_SSL_VERIFYPEER, false);
$service = curl_exec($a_handle);
?>
```

Before the changes are applied, you need to confirm them and then save them so that they become part of your configuration. This can be done in two ways, either by Saving changes in the OP5 Monitor GUI, or by adding an additional call via the REST API:

**additional save call**

``` {.php data-syntaxhighlighter-params="brush: php; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: php; gutter: false; theme: Confluence"}
<?php
$a_handle = curl_init('{your.op5.monitor}/api/config/change');
curl_setopt($a_handle, CURLOPT_USERPWD, 'joe:joespassword');
curl_setopt($a_handle, CURLOPT_CUSTOMREQUEST, 'POST');
curl_setopt($a_handle, CURLOPT_SSL_VERIFYPEER, false);
$save = curl_exec($a_handle);
?>
```

Now, visiting [https://{your.op5.monitor}/api/config/host/my\_server](https://op5-server/api/config/host/my_server) in a web browser should show you the live configuration.

## REST and LDAP

When you have more than one authentication module, such as "Local" and "LDAP", you need to specify which you are calling. This is done with the dollar character ('\$'). Thus, this regular call:

`curl -u user:password https://{your.op5.monitor}/api/status/host`

becomes:

`curl -u 'user$LDAP:password' https://{your.op5.monitor}/api/status/host`

or:

`curl -u 'user$Local:password' https://{your.op5.monitor}/api/status/host`

The dollar sign ('\$') requires single quoting depending on the environment (in bash, it will always need to be quoted). The first way of calling the API will still work, provided that you want to authenticate against the default driver. To select a different default authentication driver, use the **Configure -\> Auth Modules** section in the GUI.**
**


