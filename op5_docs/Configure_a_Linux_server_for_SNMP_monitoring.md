# Configure a Linux server for SNMP monitoring

-   [Introduction and addition of user](#ConfigureaLinuxserverforSNMPmonitoring-Introductionandadditionofuser)
    -   [SNMPv3 user](#ConfigureaLinuxserverforSNMPmonitoring-SNMPv3user)
    -   [SNMPv2c user](#ConfigureaLinuxserverforSNMPmonitoring-SNMPv2cuser)
    -   [Disable SNMPv1 user](#ConfigureaLinuxserverforSNMPmonitoring-DisableSNMPv1user)
-   [Extend the SNMP daemon to run local scripts and plugins](#ConfigureaLinuxserverforSNMPmonitoring-ExtendtheSNMPdaemontorunlocalscriptsandplugins)
    -   [Scripts](#ConfigureaLinuxserverforSNMPmonitoring-Scripts)
    -   [Plugins (binary file)](#ConfigureaLinuxserverforSNMPmonitoring-Plugins(binaryfile))
-   [OP5 Monitor: Open Source Network Monitoring](#ConfigureaLinuxserverforSNMPmonitoring-OP5Monitor:OpenSourceNetworkMonitoring)

# Introduction and addition of user

If you want to use SNMP to monitor your Linux- and UNIX-servers, it's imperative that you configure the SNMP daemon on those servers to make them respond to queries from the OP5 Monitor server.

Most people will want to use SNMP version 3 in the "authenticated and privacy protected" mode, commonly abbreviated as authPriv, but other methods are also covered in this section.Please note that the SNMP protocol version 1 and 2c is un-encrypted, so someone capable of reading traffic flows in your network will be able to read values (including community names) from queries and responses sent to and from the SNMP-monitored device.SNMP version 1 has limits in both performance and the datatypes it offers that makes it highly unsuitable for monitoring, so we strongly advise against using it.

SNMP version 3 and 2c both provide the same data and although version 3 has a slight performance overhead because it encrypts the traffic, the ease of management of using the same protocol across the network makes a very strong case for using only SNMP version 3. 
 

-   This HOW-TO assumes that net-snmp is installed on the server that should be monitored.
-   The servers that should be monitored needs to be reachable on port 161, TCP and UDP.
-   The snmp daemon's configuration file is commonly found at /etc/snmp/snmpd.conf but some operating systems put it in other places.
-   Safe passwords that are still easy to work with can be constructed of a few words strung together, like "horse.eats.bananas"
-   It's often a good idea to avoid shell meta-characters in passwords and community names. The most common problematic ones are **\$\~!;?\*()[]\\"'**
-   Remember to restart snmpd after reconfiguring it.

## SNMPv3 user

SNMP version 3 has three separate options for security and privacy (called security level, or secLevel for short);

-   **noAuthNoPriv** (no authentication, no privacy)
-   **authNoPriv** (authentication but no privacy)
-   **authPriv** (authentication and privacy)

SNMPv3 provides two different authentication mechanisms:

-   **md5 - **is now mostly supported for backward compatibility
-   **sha1** - is a much stronger cryptographic algorithm that is also faster to compute, there's no reason to use md5.

SNMPv3 also provides two different encryption algorithms:

-   **DES** - has known security issues and provides weak encryption, so it should be avoided
-   AES - use whenever possible

To add a new SNMP v3 user you need to edit two files:

-   `/var/lib/net-snmp/snmpd.conf` (createuser commands goes here)
-   `/etc/snmp/snmpd.conf` (access configuration goes here)

Don't forget to change the usernames and passwords (**authPass** and **privPass** in the example below) to secure ones of your own choosing.

Before you start to add a new SNMP v3 user you need to stop the snmp daemon:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
service snmpd stop
```

Now in `/var/lib/net-snmp/snmpd.conf` add the following line at the end of the file:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
createUser    op5user SHA authPass AES privPass
```

When snmpd is started, after you are done adding your user, the createUser command line in `/var/lib/net-snmp/snmpd.conf` will be changed to a line looking like this:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
usmUser 1 3 0x80001f88801fe67e4b048e4d5500000000 0x6b616b6100 0x6b616b6100 NULL .1.3.6.1.6.3.10.1.1.2 0xcab3cb478072eef2df19c0403f030678 .1.3.6.1.6.3.10.1.2.4 0x0f6c0d5d2e521c53630039b1f04354d8 0x
```

At the end of `/etc/snmp/snmpd.conf` you add (to give the new user read-only access to the full tree):

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
rouser        op5user priv .1
```

Start up the snmp daemon again:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
service snmpd start
```

The above example will allow the user 'op5user', authenticated with 'authPass' and submitting 'privPass' as a communication encryption key read access to the SNMP tree.

To verify the configuration, perform an snmpwalk in a terminal which should result in lots of output.
If you don't get the output, we recommend checking your snmpd configuration for errors, restart snmpd and make sure that you have configured your firewalls correctly.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
 $ snmpwalk -v 3 -l authPriv -u op5user -a sha -A authPass -x aes -X privPass localhost .1
```

Below are more examples that show the possible ways to create snmp version 3 users and enabling them for read-only access.
We strongly advise against using SNMP version 3 without authentication and encryption.

**`/var/lib/net-snmp/snmpd.conf:`**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# Create users with all varying levels and types of authentication credentials
# If a password or hash/encryption type is omitted, requiring those credentials
# upon queries will result in a configuration error when starting snmpd.
#            username      authProto  authPass   privProto   privPass
createUser   auth_none
createUser   auth_md5        MD5      md5_pass
createUser   auth_md5_des    MD5      md5_pass   DES         des_crypt
createUser   auth_md5_aes    MD5      md5_pass   AES         aes_crypt
createUser   auth_sha        SHA      sha_pass
createUser   auth_sha_des    SHA      sha_pass   DES         des_crypt
createUser   auth_sha_aes    SHA      sha_pass   AES         aes_crypt
```

`/etc/snmp/snmpd.conf:`

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# Allow user 'auth_none' read-only access to the entire SNMP tree
#        user           mode      subtree
rouser   auth_none      noauth    .1
rouser   auth_sha       auth      .1
rouser   auth_md5       auth      .1
rouser   auth_sha_des   priv      .1
rouser   auth_sha_aes   priv      .1
rouser   auth_md5_des   priv      .1
rouser   auth_md5_aes   priv      .1
```

If you choose to use SNMP version 3, you should disable unencrypted access to the server to prevent unauthorized access.
In order to do that, comment out all lines starting with **com2sec** or **access**, as well as all lines starting with **rocommunity** or **rwcommunity** from your snmpd configuration file. 

## SNMPv2c user

An argument can be made for using SNMP version 2c as it provides the same data as SNMP version 3 while at the same time is easier to debug and troubleshoot.
It also provides a slight performance benefit that is, usually, negligible. Our recommendation is that you use SNMP version 3.
Enabling SNMP version 2c while keeping SNMP version 1 disabled means you have to configure specific access groups.That's not really a bad thing, since it allows you to control very finely which areas of the SNMP tree you want to allow a particular reader to have access to.Here's an example, which configures the community name **everything** to have read-only access to everything, while the community **disks** only has read access to storage information.
Neither of the communitys provides write access to the SNMP tree.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# Map 'disks' community to the 'disksOnly' user
# Map 'everything' community to the 'allThings' user
#         sec.name   source    community
com2sec   disksOnly  default   disks
com2sec   allThings  default   everything

# Map 'disksOnly' to 'diskGroup' for SNMP Version 2c
# Map 'allThings' to 'allGroup' for SNMP Version 2c
#                sec.model sec.name
group diskGroup   v2c      disksOnly
group allGroup    v2c      allThings

# Define 'diskView', which includes everything under .1.3.6.1.2.1.25.2.3.1
# Define 'allView', which includes everything under .1 (which is everything)
#                  incl/excl   subtree
view    diskView   included    .1.3.6.1.2.1.25.2.3
view    allView    included    .1

# Give 'diskGroup' read access to objects in the view 'diskView'
# Give 'allGroup' read access to objects in the view 'allView'
#         group     context   model   level    prefix  read       write   notify
access    diskGroup   ""      any     noauth   exact   diskView   none    none
access    allGroup    ""      any     noauth   exact   allView    none    none
```

## Disable SNMPv1 user

As explained above, SNMP version 1 has limitations both in terms of performance and in terms of the data it can deliver that makes it unsuitable for monitoring.
It's also (usually) pre-configured with the default community of **public** for readonly access. We strongly suggest that you disable it in order to prevent malicious users from gaining information about the server.
In order to do so, you need to remove or comment out all lines in your snmpd configuration file that start with **rocommunity** or **rwcommunity**.
Note that this will also prevent the community strings thus configured from working with SNMP version 2c access.

# Extend the SNMP daemon to run local scripts and plugins

This section briefly cover how to run custom scripts on a localhost, we assume that you have followed the instructions in the previous section and have your SNMP daemon setup correctly with a SNMPv3 user.
After following this article you will be able to use monitor to execute scripts via SNMP which are run on an external machine where you have configured the SNMP daemon to run the script you would like to execute.
For more information visit the Red Hat Customer Portal have an extensive guide about [extending net-snmp](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/sect-System_Monitoring_Tools-Net-SNMP-Extending.html).

## Scripts

Add the following to your snmp.conf (usually **/etc/snmp/snmpd.conf**, as stated above):

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
extend myscriptalias /bin/sh /tmp/myscript.sh
```

Restart the SNMP daemon:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
$ sudo service snmpd restart
```

Create the temporary example script file:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
$ touch /tmp/myscript.sh
```

And add the following example code to it:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
#!/bin/sh
echo Hello world!
exit 0
```

Make the file executable:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
$ chmod +x /tmp/myscript.sh
```

You can now perform an snmpwalk to verify that everything is working:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
$ snmpwalk -v 3 -l authPriv -u op5user -a sha -A authPass -x AES -X privPass localhost .1.3.6.1.4.1.8072.1.3
```

You should be able to find the following information in the output:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
NET-SNMP-EXTEND-MIB::nsExtendNumEntries.0 = INTEGER: 1
NET-SNMP-EXTEND-MIB::nsExtendCommand."myscriptalias" = STRING: /bin/sh
NET-SNMP-EXTEND-MIB::nsExtendArgs."myscriptalias" = STRING: /tmp/myscript.sh
NET-SNMP-EXTEND-MIB::nsExtendOutputFull."myscriptalias" = STRING: Hello world!
NET-SNMP-EXTEND-MIB::nsExtendResult."myscriptalias" = INTEGER: 0
```

To run your script from monitor, just add the host you just configured and add the check check\_by\_snmp\_extend\_v3 with the following check command arguments:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
-U op5user -a sha -A authPass -x AES -X privPass!myscriptalias
```

The result should be an OK check result with the output "Hello world!".

## Plugins (binary file)

This is an example of how to add the plugin check\_load from /opt/plugins/ to another machine and then run it via SNMP.
This is just to show how to run a binary file via the extend command, you would probably want to use your own plugin file.
Assuming that you have acquired your own or the check\_load plugin and placed it in /tmp/check\_load on the machine you would like to run it on.

Add the following to your snmp.conf (usually **/etc/snmp/snmpd.conf**, as stated above):

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
extend check_load /tmp/check_load -w1,2,3 -c4,5,6
```

Restart the SNMP daemon:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
$ sudo service snmpd restart
```

Confirm the change with an snmpwalk:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
$ snmpwalk -v 3 -l authPriv -u op5user -a sha -A authPass -x AES -X privPass localhost .1.3.6.1.4.1.8072.1.3
```

And you should be able to find the following:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
NET-SNMP-EXTEND-MIB::nsExtendCommand."check_load" = STRING: /tmp/check_load
NET-SNMP-EXTEND-MIB::nsExtendArgs."check_load" = STRING: -w1,2,3 -c4,5,6
NET-SNMP-EXTEND-MIB::nsExtendOutputFull."check_load" = STRING: OK - load average: 0.00, 0.00, 0.00|load1=0.000;1.000;4.000;0; load5=0.000;2.000;5.000;0; load15=0.000;3.000;6.000;0; 
NET-SNMP-EXTEND-MIB::nsExtendResult."check_load" = INTEGER: 0
```

To run your script from monitor, just add the host you just configured and add the check check\_by\_snmp\_extend\_v3 with the following check command arguments:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
-U op5user -a sha -A authPass -x AES -X privPass!check_load
```

The result should be an OK/WARNING/CRITICAL/UNKNOWN check result with the output of the load average.

# OP5 Monitor: Open Source Network Monitoring

[OP5 ](https://www.op5.com/)is the preferred Open Source Networking & Server Monitoring tool for large multi-national companies in over 60 markets. If you would like to experience OP5 Monitor you can get started here, alternatively, if you prefer to get more hands on you can Download OP5 Monitor for free. 

 

