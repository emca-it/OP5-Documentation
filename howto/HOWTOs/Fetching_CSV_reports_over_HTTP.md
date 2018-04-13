# Fetching CSV reports over HTTP

- [Authentication](https://kb.op5.com/display/HOWTOs/Fetching+CSV+reports+over+HTTP#FetchingCSVreportsoverHTTP-Authentication)
- [Report parameters](https://kb.op5.com/display/HOWTOs/Fetching+CSV+reports+over+HTTP#FetchingCSVreportsoverHTTP-Reportparameters)
- [Caveats](https://kb.op5.com/display/HOWTOs/Fetching+CSV+reports+over+HTTP#FetchingCSVreportsoverHTTP-Caveats)
- [References](https://kb.op5.com/display/HOWTOs/Fetching+CSV+reports+over+HTTP#FetchingCSVreportsoverHTTP-References)

The OP5 Monitor HTTP API provides access to report data, delivering the E in the [ETL model](http://en.wikipedia.org/wiki/Extract,_transform,_load) for customers interested in performing their own report analysis in a data warehouse solution. In some cases, custom analysis is not required and in those cases the data in the standard OP5 Monitor reports often provides the necessary information. OP5 Monitor does not provide an API for getting existing reports so this solution is not guaranteed to work in the future, but they can be fetched over HTTP with a little work. To do this, two steps are required: authentication and setting parameters.

## Authentication

Note: Authenticating using GET parameters can be a security risk, since the username and password will be part of the URL and therefore can be exposed in various places such as the address bar of the web browser, web server log files and saved bookmarks.

1. Create the file /opt/monitor/op5/ninja/application/config/custom/auth.php with the following contents (make sure you keep your old settings if you have customized other authentication settings)
2. Add the following:

        <?php defined('SYSPATH') OR die('No direct access allowed.');

        /** * Setting this to TRUE will allow you to access any page by * appending ?username=<username>&password=<password> to the URL. * * Warning: this is insecure! Do know what you're doing! */$config['use_get_auth'] = true;

You can now add the username and password as GET parameters to any ninja URL and be logged in automatically. Example:

https://192.168.1.150/monitor/index.php/alert\_history/generate?username=monitor&password=monitor

Note that different authentication types may need to be identified. Active Directory users can be marked using the *\$Default* parameter after the username but before the password. Example:

https://192.168.1.150/monitor/index.php/alert\_history/generate?username=monitor\$Default&password=monitor

## Report parameters

Set up the report you want to generate by using the OP5 Monitor web interface. Once the report is generated, click the "Direct link" button and copy the URL. You can now use the URL from curl or another tool. Append **&output\_format=csv** and then append the authentication mentioned above.

As this is not an API, the parameter names and meaning may change between releases so make sure you verify on each upgrade.

It is likely that you'll want to modify the time parameters in the URL when generating the report, to reflect the time when the report is generated:

parameter name

example value

description

start\_time

1385049008

Unix timestamp for the start time of the report. Will be ignored, unless report\_period is "custom".

end\_time

1385653808

Unix timestamp for the end time of the report. Will be ignored, unless report\_period is "custom".

## Caveats

Getting the data this way would put load on the Monitor server every time a report is generated, so you will need to take performance into consideration in order to not affect the monitoring. If the number of concurrent users generating reports is small, this should not be a problem.

## References

This page was created based on the information provided in <https://bugs.op5.com/view.php?id=5282> and an internal discussion in <https://bugs.op5.com/view.php?id=7968>

## Comments:

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p>Dante, if I understand correctly the customer has changed the settings for the Default auth driver to use Active Directory, and then set some other auth driver to be the default login method, hence the need to explicitly state which driver to use in the URL. To me, that configuration is bound to create confusion.</p>
<p>So the statement &quot;Active Directory users can be marked using the <em>$Default&quot;</em> is only true for a customer who has changed the Default auth driver to use Active Directory instead of the standard local login. Some other customer might have a different name for their Active Directory driver.</p>
<p>More information about selecting auth driver: <a href="https://demo.op5.com/api/help/filter#trouble_login_custom_auth">https://demo.op5.com/api/help/filter#trouble_login_custom_auth</a></p>
<img src="images/icons/contenttypes/comment_16.png" /> Posted by mfalkvidd at Jan 31, 2017 02:23</td>
</tr>
</tbody>
</table>
