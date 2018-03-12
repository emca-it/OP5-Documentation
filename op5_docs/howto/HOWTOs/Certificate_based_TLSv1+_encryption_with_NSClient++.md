# Certificate based TLSv1+ encryption with NSClient++

Version

This article was written for version 0.4.4 of NSClient++. Versions 0.3.x and earlier of NSClient++ did not rely on the Windows Registry as heavily, so these notes would not apply. These instructions should work on later versions unless otherwise noted.

Articles in the Community-Space are not supported by op5 Support.

 

As per default encrypted communication with NRPE & NSClient++ is using ADH cipher ([Anonymous Diffie Hellman](https://wiki.openssl.org/index.php/Diffie_Hellman#Diffie-Hellman_in_SSL.2FTLS)) and a static predefined 512bit DH key.
To achieve a more secure encryption method with a better cipher, ability to disable SSLv2 & SSLv3, we need to create certificates, reconfigure the agent and upgrade check\_nrpe used for NRPE checks in OP5 Monitor.

This HOWTO is focused on NSClient++ for Windows, but the same is also achievable with an upgraded version of NRPE.

First of this requires **NSClient++ \>= 0.4.x** and **NRPE \>= 3.0.x** since these are the versions where real SSL/TLS support was added to the agents and check\_nrpe.

To start off, I've created self-signed certificate with a CA so I can easily add new hosts with unique client certificates in the future, to have the possibility to use certificate authentication between OP5 Monitor & hosts.

If you don't have a CA certificate in place in your organization, here's a small HOWTO: [Create a self-signed CA & client certificate with OpenSSL](Create_a_self-signed_CA_client_certificate_with_OpenSSL)

## NSClient++

On the host I monitor and where I want to secure the communications to, I saved my certificate, private key & CA certificate in **C:\\Program Files\\NSClient++\\security. **

Next step is to change some options for NSClient++.
Pro tip: See our HOWTO on how to change NSClient++ settings within Windows registry: [Handling NSClient++ settings in the Windows Registry](Handling_NSClient++_settings_in_the_Windows_Registry)

All of these settings are located at **/settings/NRPE/server **within NSClient++ settings structure. Registry path: **[HKEY\_LOCAL\_MACHINE\\SOFTWARE\\NSClient++\\settings\\NRPE\\server]**

Settings name

Recommended value

Default value

allowed ciphers

ALL:!ADH:!LOW:!EXP:!MD5:@STRENGTH

ADH

ca

\${certificate-path}/rootCA.pem

UNDEFINED KEY

certificate

\${certificate-path}/client\_name.pem

UNDEFINED KEY

certificate key

\${certificate-path}/klient.key

UNDEFINED KEY

dh

(empty)

\${certificate-path}/nrpe\_dh\_512.pem

insecure

false

true

ssl options

no-sslv2,no-sslv3

UNDEFINED KEY

Here's a quick explanation about each setting.

-   allowed cipher - Here we change from only allowing ADH to allow all ciphers except ADH and some other insecure cipher methods, and then sort the ciphers based on strength with @STRENGTH.
-   ca - Point to the ca-certificate, \${certificate-path} is by default pointing to  **C:\\Program Files\\NSClient++\\security**.
-   certificate - Point to the client certificate.
-   certificate key - Point to the private key that belongs to the client certificate.
-   dh - Since we're going to stop using ADH with a static DH key, we simply remove this option.
-   insecure - this setting is used because of legacy NRPE, since the next step is to upgrade and replace check\_nrpe we change this to **false**
-   ssl options - Here I'm adding no-sslv2 & no-sslv3 to disable the possibility to use these since they're considered to be insecure. Now we're only allowing TLSv1+

*Don't forget to restart the NSClient++ service after the changes are done, or else they won't take effect.*

## check\_nrpe v3

Since legacy check\_nrpe (\< 3.0.x) only have the possibility to use ADH cipher for encrypted communication, we need to compile a newer version to use for our checks.

These instructions are based on CentOS 6 which OP5 Monitor APS is based on (as of today when this HOWTO is written), equivalent steps are possible on other distributions i.e Debian.

Following packages need to be installed in order to compile check\_nrpe.

yum install -y gcc glibc glibc-common openssl-devel perl wget

Let's go to tmp, download the latest version av nrpe (3.0.1 as of today when this HOWTO is written), and extract the compressed archive.

cd /tmp
wget --no-check-certificate <https://github.com/NagiosEnterprises/nrpe/releases/download/3.0.1/nrpe-3.0.1.tar.gz>
tar xzf nrpe\*

Next thing is to configure and compile check\_nrpe. The compiled binary will be available in **src/** directory, so let's copy the new version of check\_nrpe to custom plugin directory of OP5 Monitor so we can configure custom checks in OP5.

cd nrpe-3.0.1
./configure --enable-command-args
make check\_nrpe
cp src/check\_nrpe /opt/plugins/custom/check\_nrpe\_v3 

 

It's not possible to just replace the existing check\_nrpe without changing / creating new checks. The reason is the -s flag that's used in all the default OP5 check\_nrpe command checks, which forces encryption, now has a different purpose in version 3.0+.
I recommend that you create new custom command checks because the default ones shipped with OP5 Monitor might be reset & overwritten during an update. 

To give an example, below check for CPU usage on Windows, I've only removed the -s flag from the original check command. This will work against your new NSClient++ setup, using TLSv1+ without ADH cipher.

./check\_nrpe\_v3 -H HOSTNAME/IP -c CheckCPU -a ShowAll=long MaxWarn=80% MaxCrit=90%

 

And that's it, you're done and are now using a proper encrypted TLS connection between your OP5 Monitor and the monitored host. Compared to the legacy check\_nrpe there are several new options and possibilities to specify settings for the encryption and even certificate based authentication.

NRPE Plugin for Nagios
Copyright (c) 1999-2008 Ethan Galstad (nagios@[nagios.org](http://nagios.org))
Version: 3.0.1
Last Modified: 09-08-2016
License: GPL v2 with exemptions (-l for more info)
SSL/TLS Available: OpenSSL 0.9.6 or higher required

 

Usage: check\_nrpe -H \<host\> [-2] [-4] [-6] [-n] [-u] [-V] [-l] [-d \<dhopt\>]
 [-P \<size\>] [-S \<ssl version\>] [-L \<cipherlist\>] [-C \<clientcert\>]
 [-K \<key\>] [-A \<ca-certificate\>] [-s \<logopts\>] [-b \<bindaddr\>]
 [-f \<cfg-file\>] [-p \<port\>] [-t \<interval\>:\<state\>]
 [-c \<command\>] [-a \<arglist...\>]

 

Options:

\<host\> = The address of the host running the NRPE daemon
 -2 = Only use Version 2 packets, not Version 3
 -4 = bind to ipv4 only
 -6 = bind to ipv6 only
 -n = Do no use SSL
 -u = (DEPRECATED) Make timeouts return UNKNOWN instead of CRITICAL
 -V = Show version
 -l = Show license
 \<dhopt\> = Anonymous Diffie Hellman use:
 0 = Don't use Anonymous Diffie Hellman (This will be the default in a future release.)
 1 = Allow Anonymous Diffie Hellman (default)
 2 = Force Anonymous Diffie Hellman
 \<size\> = Specify non-default payload size for NSClient++
 \<ssl ver\> = The SSL/TLS version to use. Can be any one of: SSLv2 (only),
 SSLv2+ (or above), SSLv3 (only), SSLv3+ (or above),
 TLSv1 (only), TLSv1+ (or above DEFAULT), TLSv1.1 (only),
 TLSv1.1+ (or above), TLSv1.2 (only), TLSv1.2+ (or above)
 \<cipherlist\> = The list of SSL ciphers to use (currently defaults
 to "ALL:!MD5:@STRENGTH". WILL change in a future release.)
 \<clientcert\> = The client certificate to use for PKI
 \<key\> = The private key to use with the client certificate
 \<ca-cert\> = The CA certificate to use for PKI
 \<logopts\> = SSL Logging Options
 \<bindaddr\> = bind to local address
 \<cfg-file\> = configuration file to use
 [port] = The port on which the daemon is running (default=5666)
 [command] = The name of the command that the remote daemon should run
 [arglist] = Optional arguments that should be passed to the command,
 separated by a space. If provided, this must be the last
 option supplied on the command line.

 

NEW TIMEOUT SYNTAX
 -t \<interval\>:\<state\>
 \<interval\> = Number of seconds before connection times out (default=10)
 \<state\> = Check state to exit with in the event of a timeout (default=CRITICAL)
 Timeout state must be a valid state name (case-insensitive) or integer:
 (OK, WARNING, CRITICAL, UNKNOWN) or integer (0-3)

 

Note:
This plugin requires that you have the NRPE daemon running on the remote host.
You must also have configured the daemon to associate a specific plugin command
with the [command] option you are specifying here. Upon receipt of the
[command] argument, the NRPE daemon will run the appropriate plugin command and
send the plugin output and return code back to \*this\* plugin. This allows you
to execute plugins on remote hosts and 'fake' the results to make Nagios think
the plugin is being run locally.

 

