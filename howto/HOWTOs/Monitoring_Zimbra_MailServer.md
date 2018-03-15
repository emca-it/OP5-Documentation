# Monitoring Zimbra MailServer

Version

This article was written for version 7.0 of Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by op5 Support.

# Introduction

This how-to will help you monitor Zimbra 8 MailServer. This how-to is tested with the open source version but should work with the other versions as well.

# Prerequisites

Before we start there are a couple of things that needs to be working.

-   Working Zimbra installation 
-   NRPE should be installed on the Zimbra server and allowing connections from the op5 Monitor server.
-   You need root access to the Zimbra server 

# About

This how-to require a plugin to be installed on the server and special sudo permissions.

![](attachments/12190176/12386386.png)

# Installing plugin

1.  Copy [this script](attachments/12190176/12386383.pl) to the folder /opt/plugins/custom on your Zimbra server.
2.  Change the permissions to 755 on the script.
3.  Modify the sudo permissions with the command *vimudo*
    1.  Add the following lines to the configuration

        ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
        %zimbra ALL=NOPASSWD:/opt/zimbra/bin/zmcontrol
        nobody ALL=NOPASSWD:/opt/plugins/custom/check_zmstatus.pl
        ```

        This will allow the zimbra user to execute the zmcontrol command. 

    2.  Save the configuration

# Configure NRPE

NRPE needs to be updated, ether put [this file](attachments/12190176/12386384.cfg) under /opt/nrped.d/ or add the following commands manually

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
command[zimbra_clamd]=/opt/plugins/check_clamd /opt/zimbra/data/clamav/clamav.sock
command[zimbra_lmtp]=/opt/plugins/check_smtp -H localhost -p 7025
command[zimbra_spellcheck]=/opt/plugins/check_http -H localhost -p 7780
command[zimbra_dns]=/opt/plugins/check_dns -H google.com
command[zimbra_cert]=/opt/plugins/check_http -S -H localhost -C 30
command[zimbra_submission]=/opt/plugins/check_smtp -H localhost -p 587
command[zimbra_imaps]=/opt/plugins/check_imap -H localhost -S -p 993
command[zimbra_imap]=/opt/plugins/check_imap -H localhost -p 143
command[zimbra_pop]=/opt/plugins/check_pop -H localhost
command[zimbra_pops]=/opt/plugins/check_pop -H localhost -S -p 995
command[zimbra_mailq]=/opt/plugins/check_mailq -w 5 -c 10 -M postfix
command[zimbra_services]=/usr/bin/sudo /opt/plugins/custom/check_zmstatus.pl
command[zimbra_smtp]=/opt/plugins/check_smtp -H localhost
```

# Modify plugins settings

Edit the file /opt/plugins/utils.pm on the Zimbra server, change the line

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
$PATH_TO_MAILQ   = "";
```

to 

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
$PATH_TO_MAILQ   = "/opt/zimbra/postfix-2.11.1.2z/sbin/mailq";
```

Verify the path so that that it corresponds with your Zimbra installation.

This will allow the plugin check\_mailq to find the path to you mail queue folder. 

# Add Management Pack

In [this Management Pack](attachments/12190176/12386385.json) all services are defined. Add the management pack using Management pack manager under Configure.  

Depending on the services you make available on you Mailserver some services perhaps needs modification.

