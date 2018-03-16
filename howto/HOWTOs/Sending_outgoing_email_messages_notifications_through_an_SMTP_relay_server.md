# Sending outgoing email messages (notifications) through an SMTP relay server

## Introduction

A very common way of transmitting email messages in server systems is by sending them directly to other mail servers on the Internet using the SMTP protocol. However, many networks filter outgoing SMTP connections (port TCP/25 outwards). Since default RHEL / CentOS / APS installations will try to send email messages this way, email based alert notifications might not go through as expected in all environments.

This issue is often resolved by making sure that the local mail server (e.g. the Postfix daemon running at the Monitor server) sends its outgoing mail through a relaying mail server (one often located within your internal network, or one belonging to your ISP).

 

## Prerequisites

Before we can start configuring the system, you need to make sure that:

-   the Monitor server is running the [Postfix ](http://www.postfix.org/)daemon (execute the `service postfix status` command to find out)
-   you know which relay server to use (IP address, hostname, etc.), including any required authentication details 

 

 

Configuring Postfix 

### Using an open relay server (no authentication)

### OP5 Appliance System (APS)

The APS lets you configure the relay server using the web based configuration tool (Portal).

#### CentOS / RHEL

1.  Log on to your `root` account at your Monitor server using SSH.
2.  Edit the Postfix main configuration file `/etc/postfix/main.cf`
3.  Insert an option such as this:
    relayhost = [domain.name.of.relay.server]
4.  Restart the Postfix daemon by running the following command as root:
    service postfix restart

### Using a relay server with authentication

Depending on the configuration of the relaying mail server, different authentication mechanisms are required. In this case, the basic plain authentication mode will be used.

1.  Log on to your `root` account at your OP5 Monitor server using SSH.
2.  Create a new SASL authentication file unless one already exists.
    1.  Run the following commands:
        `[ -e /etc/postfix/sasl_passwd ] || : > /etc/postfix/sasl_passwd`
        `chown root: /etc/postfix/sasl_passwd`
        `chmod 600 /etc/postfix/sasl_passwd `
    2.  Edit the file and insert your user details, like this:
        `your.relay.server.host.name email.account@relay.server:password`
        ``
    3.  Any changes to this file requires an update of its corresponding binary lookup table file. The plain text file will be processed using this command:
        `postmap hash:/etc/postfix/sasl_passwd `
    4.  The file */etc/postfix/sasl\_passwd.db* should now have been created or updated. The following command will verify that your changes have been inserted:
        `postmap -s hash:/etc/postfix/sasl_passwd `

3.  **Optionally**, use address rewriting to transform the sender address in outgoing email messages. For example, if your server running Monitor is set up with a system host name such as *op5-system.localdomain*, the sender address in outgoing email notifications from Monitor will be set to *monitor@op5-system.localdomain*. Restrictive relay servers might reject email messages with invalid (e.g. non-external) sender addresses from getting through and the message will just bounce back. One way of handling this is by rewriting the address.
    1.  Edit the Postfix configuration file called `/etc/postfix/generic`
    2.  Insert the address rewrite like this, for example (where the latter address represents a fully valid email address/account):
        `monitor@op5-system.localdomain monitor@your.company.domain.name`
    3.  Any changes to this file requires an update of its corresponding binary lookup table file. The plain text file will be processed using this command:
        `postmap /etc/postfix/generic`
    4.  Make sure to add the `smtp_generic_maps` setting into `/etc/postfix/main.cf `and then restart Postfix as described in step 4 and 5 below.` `

4.  Edit the Postfix main configuration file.
    1.  Open up `/etc/postfix/main.cf` using your favorite text editor.
    2.  Insert the following options:
        `smtp_sasl_auth_enable = yes``smtp_sasl_mechanism_filter = plain, login`
        `smtp_sasl_security_options = noanonymous`
        `smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd`
        `smtp_generic_maps = hash:/etc/postfix/generic``relayhost = [domain.name.of.relay.server]`
        NOTE: smtp\_generic\_maps is only needed if step 3 above was performed.
    3.  If the smtp server requires TLS authentication, (for example Office365) then also add the following option:smtp\_tls\_security\_level = encrypt
    4.  If using Office365, set postfix to use ipv4 only by adding the following option:inet\_protocols = ipv4 

5.  Finally, restart the local Postfix server daemon by running the following command:
    `service postfix restart`

     

## Verifying that it works

### **Sending a test message**

#### OP5 Appliance System (APS)

Enter the Email Settings page in the Portal and send a test message.

 

#### CentOS / RHEL

1.  Log on to your Monitor server using SSH.
2.  Send a test message by running the following command (make sure to substitute the email address!):echo testbody | mail -s testsubject your@mail.addressIs the `mail` command missing? Make sure to install the `mailx` package in the system:
    `yum install mailx`

### **Troubleshooting**

#### Finding (error) log messages

1.  Log on to your root account at your OP5 Monitor server using SSH.
2.  Monitor the system mail log file by running the following command:
    `tail -n0 -F /var/log/maillog`
3.  Meanwhile, send a test message using one of the methods outlined above.
4.  You should now see information about your email delivery. If the message fails sending, an error message will appear. This error message could be generated by either the local mail server (Postfix) or the remote relay system, or both. Please find the Postfix documentation for more information.
    1.  If you receive the message "Client was not authenticated to send anonymous mail during MAIL FROM" your smtp might require TLS authentication.

5.  Several error messages, such as the ones below, are related to the SASL settings in the Postfix configuration; especially the smtp\_sasl\_mechanism\_filter* *option. It could also be related to missing libraries, see section regarding missing software packages below.
    -   *warning: SASL authentication failure: No worthy mechs found*
    -   *warning: mail.relay.server[192.0.2.10]:25 offered no supported AUTH mechanisms: 'PLAIN LOGIN'*
    -   *status=deferred (SASL authentication failed; cannot authenticate to server relay.mail.server[192.0.2.10]: no mechanism available)*
    -   *status=deferred (SASL authentication failed: server mail.relay.server[192.0.2.10] offered no compatible authentication mechanisms for this type of connection security)
        *

*
*

#### Missing software packages

Using the SASL authentication methods in Postfix requires that the corresponding Cyrus SASL libraries have been installed in the system. Verify this by running the following command:
`rpm -q cyrus-sasl cyrus-sasl-plain cyrus-sasl-md5`
Several different packages exists for different types of authentication methods. Find out which ones that are available by running the following command:yum search cyrus-saslInstalling any of those is just a matter of e.g. yum install cyrus-sasl-ntlm

Note: If configuring this for Office365, you need to use a regular mailbox account, not a shared office 365 Mailbox.

 

# OP5 Monitor: Open Source Network Monitoring

[OP5 ](https://www.op5.com/)is the preferred Open Source Networking & Server Monitoring tool for large multi-national companies in over 60 markets. If you would like to experience OP5 Monitor you can get started here, alternatively, if you prefer to get more hands on you can Download OP5 Monitor for free. 

 

### [Download OP5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)

 

