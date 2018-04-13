# Upgrading from OP5 Monitor 6.x to 7.x

Version

This article was written for version 6.3 of OP5 Monitor, it could work on both lower and higher version if nothing else is stated.

# Introduction

In this short guide we will look at upgrading an *op5 Monitor* instance or appliance system from version 6.x to 7.x.

Taking a backup before system and application upgrade is always recommended - find more information about backing up *op5 Monitor* [here](https://kb.op5.com/display/DOC/Configuration+backup+tool)

# Upgrade process

Make sure that your system is fully updated and all repository data is up-to-date:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# yum clean all && yum update
```

Install the "op5-release-up-6-to-7" meta package:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# yum install op5-release-up-6-to-7
```

~~
~~Upgrade your system with the new "6-to-7" repositories enabled:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# yum --enablerepo='*6-to-7*' upgrade
```

Once the upgrade has finished, reboot your system and enjoy your new version of *op5 Monitor*:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# reboot
```

# Monitor server with Logserver installed

If you are running the old Logserver on your 6.x server, you will see the following error when trying to upgrade:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
Error: op5-syslog-ng conflicts with op5-logserver-connector-fs-3.6.3-op5.1.x86_64
```

You will need to remove the Logserver packages before upgrading, since they are not compatible with the new Logger.

However, your historical data, filters and additional data such as configuration for Logserver **WILL BE REMOVED PERMANENTLY **if you remove the Logserver packages.

**Please contact our Professional Services department for migration assistance** before upgrading a Logserver server to Monitor 7.0.
