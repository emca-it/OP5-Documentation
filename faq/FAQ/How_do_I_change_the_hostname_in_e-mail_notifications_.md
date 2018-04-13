# How do I change the hostname in e-mail notifications?

## Question

* * * * *

How do I change the host name for my OP5 Monitor server in status links within e-mail notifications?
My users use another domain name to access the monitoring system.

## Answer

* * * * *

By default, the monitoring servers host name will be used in links.
If you want to override that setting, you need to create a configuration file for "notify" and set the "hostname" property:

**Commands on the monitoring server**

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# echo "hostname: hostname.in.notifications" >> /etc/op5/notify.yml
# chown monitor:apache /etc/op5/notify.yml
# chmod 664 /etc/op5/notify.yml
```
