# Secure communication with Cloud poller

op5 Monitor can be used in a distributed monitoring set up with a master system and one or several pollers. The pollers can be cloud based or setup as standard local poller using [op5 Poller Extension](http://www.op5.com/extensions/op5-monitor-poller-extension/ "op5 monitor poller extension"). This how-to describes how to secure the communication between master and cloud or normal poller using openVPN.

## Design

### Poller

openvpn server

IP: 10.1.0.1

### Master

openvpn client

IP: 10.1.0.2

## Requirements

-   `At least OpenVPN 2.2.0 from op5 repository on both master and poller. `\# yum install openvpn

## How-to

### Poller-side configuration

-   Login to poller as root
-   Edit /etc/hosts to add the masters IP on the poller with a name
-   Enable execution of scripts

`# cd /usr/share/doc/openvpn-2.2.2/easy-rsa/2.0 # chmod +x *`

-   Edit vars file and change the following values, examples below:

`export KEY_COUNTRY="SE" export KEY_PROVINCE="Stockholm" export KEY_CITY="Stockholm" export KEY_ORG="op5 AB" export KEY_EMAIL="support@op5.com"`

`# ./vars`

-   Ignore the NOTE

`#  ./clean-all # ./pkitool --initca # ./build-key-server poller-to-master`

This will generate the following output, press enter on all questions except y/n questions where you will answer ‘y’:

*—- Buffer —-
* *Generating a 1024 bit RSA private key
* *………………………………………………………++++++
* *……………++++++
* *writing new private key to ‘poller-to-master.key’*

** *—–
* *You are about to be asked to enter information that will be incorporated
* *into your certificate request.
* *What you are about to enter is what is called a Distinguished Name or a DN.
* *There are quite a few fields but you can leave some blank
* *For some fields there will be a default value,
* *If you enter ‘.’, the field will be left blank.
* *—–*

** *Country Name (2 letter code) [SV]:State or Province Name (full name) [NA]:
* *Locality Name (eg, city) [Stockholm]:
* *Organization Name (eg, company) [op5 AB]:
* *Organizational Unit Name (eg, section) []:
* *Common Name (eg, your name or your server’s hostname) [cloud-poller]:
* *Email Address [<support@op5.com>]:
* *Please enter the following ‘extra’ attributes
* *to be sent with your certificate request
* *A challenge password []:
* *An optional company name []:Using configuration from /usr/share/doc/openvpn-2.2.0/easy-rsa/2.0/openssl.cnf
* *Check that the request matches the signature
* *Signature ok
* *The Subject’s Distinguished Name is as follows
* *countryName :PRINTABLE:’SE’
* *stateOrProvinceName :PRINTABLE:’Stockholm’
* *localityName :PRINTABLE:’Stockholm’
* *organizationName :PRINTABLE:’op5 AB’
* *commonName :PRINTABLE:’cloud-poller’
* *emailAddress :IA5STRING:’support@op5.com’
* *Certificate is to be certified until Aug 30 07:48:35 2021 GMT (3650 days)
* *Sign the certificate? [y/n]: **y***

*1 out of 1 certificate requests certified, commit? [y/n]**y***

****** *Write out database with 1 new entries
* *Data Base Updated
* *—- Buffer —-*

-   Generate a Client key on the poller.

`# ./build-key internal-master-to-poller`

-   This will generate the following output, press enter on all questions except y/n questions where you will answer ‘y’:

*—- Buffer —-*
 *Generating a 1024 bit RSA private key
* *.++++++
* *…………………………………++++++
* *writing new private key to ‘internal-master-to-poller.key’*

** *—–
* *You are about to be asked to enter information that will be incorporated* *into your certificate request.
* *What you are about to enter is what is called a Distinguished Name or a DN.
* *There are quite a few fields but you can leave some blank
* *For some fields there will be a default value,* *If you enter ‘.’, the field will be left blank.
* *—–* **

*Country Name (2 letter code) [SE]:
* *State or Province Name (full name) [Stockholm]:
* *Locality Name (eg, city) [Stockholm]:
* *Organization Name (eg, company) [op5 AB]:
* *Organizational Unit Name (eg, section) []:
 IT* *Common Name (eg, your name or your server’s hostname) [internal-master-to-poller]:
 internal-master* *Email Address [<support@op5.com>]:*

*Please enter the following ‘extra’ attributes* *to be sent with your certificate request* *A challenge password []:
* *An optional company name []:
* *Using configuration from /usr/share/doc/openvpn-2.2.0/easy-rsa/2.0/openssl.cnf
* *Check that the request matches the signature* *Signature ok
* *The Subject’s Distinguished Name is as follows
* *countryName :PRINTABLE:’SE’
* *stateOrProvinceName :PRINTABLE:’Stockholm’
* *localityName :PRINTABLE:’Stockholm’
* *organizationName :PRINTABLE:’op5 AB’
* *organizationalUnitName:PRINTABLE:’IT’
* *commonName :PRINTABLE:’internal-master’
* *emailAddress :IA5STRING:’support@op5.com’
* *Certificate is to be certified until Aug 30 08:28:57 2021 GMT (3650 days)
* *Sign the certificate? [y/n]:**y***

*1 out of 1 certificate requests certified, commit? [y/n]**y*** *Write out database with 1 new entries* *Data Base Updated*

*—- Buffer —-*

-   Create the directories needed for your setup

`# cd /etc/openvpn # mkdir certs # mkdir dh # mkdir keys # mkdir /var/log/openvpn/`

-   Create the dh key

`# openssl dhparam -out dh/dh1024.pem 1024`

-   Create tls key

`# openvpn --genkey --secret keys/ta.key`

-   Copy the certificates and keys to right place

`# cp /usr/share/doc/openvpn-2.2.0/easy-rsa/2.0/keys/ca.crt certs/ # cp /usr/share/doc/openvpn-2.2.0/easy-rsa/2.0/keys/poller-to-master.crt certs/ # cp /usr/share/doc/openvpn-2.2.0/easy-rsa/2.0/keys/poller-to-master.key keys/`

-   Create a default configuration

Default configuration is stored in /etc/openvpn/master-to-poller.conf. Create this file with you favorite editor and copy/paste the code below. Remember to change parameters to match your setup.

**/etc/openvpn/master-to-poller.conf**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
local <pollers public ip>
port 1194
proto udp
dev tun
ca certs/ca.crt
cert certs/poller-to-master.crt
key keys/poller-to-master.key
dh dh/dh1024.pem
ifconfig 10.1.0.1 10.1.0.2
keepalive 10 60
tls-server
tls-auth keys/ta.key 0
user nobody
group nobody
persist-key
persist-tun
log /var/log/openvpn/master-to-poller.log
verb 4
mute 20
script-security 2
```

 

-   Add rule to IP-tables firewall chain

To allow traffic from your master to your poller you need to open the pollers firewall to let in your masters gateway. In this example 193.201.96.46 is our masters gateway to the internet, please lookup your gateway and replace the IP. You can use <http://whatismyip.org/> or contact your IT administrator.

`# iptables -I RH-Firewall-1-INPUT -s 193.201.96.46 -p udp --dport 1194 -j ACCEPT # service iptables save`

-   Set OpenVPN to autostart

`# chkconfig --level 345 openvpn on`

-   Verify installation

Test your installation and look in the logs for problems in the logs.

`# service openvpn restart`

Verify that startup is OK.
 If it does not start ok, take a look in log files. These are located in /var/log/openvpn

### Master-side configuration

-   Login to Master as root
-   Edit /etc/hosts to add the pollers IP on the master with a name
-   Copy keys to master

`# cd /etc/openvpn # mkdir certs keys logs # scp root@91.123.201.38:/usr/share/doc/openvpn-2.2.0/easy-rsa/2.0/keys/internal-master-to-poller.key keys/ # scp root@91.123.201.38:/usr/share/doc/openvpn-2.2.0/easy-rsa/2.0/keys/internal-master-to-poller.crt certs/ # scp root@91.123.201.38:/usr/share/doc/openvpn-2.2.0/easy-rsa/2.0/keys/ca.crt certs/ # scp root@91.123.201.38:/etc/openvpn/keys/ta.key keys/`

-   Create the client configuration. Remember to change IP adresses to match your setup.

**/etc/openvpn/master-to-poller.conf**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
client
dev tun
proto udp
remote <Poller public IP> 1194
resolv-retry infinite
nobind
persist-key
persist-tun
ca certs/ca.crt
cert certs/internal-master-to-poller.crt
key keys/internal-master-to-poller.key
tls-client
tls-auth keys/ta.key 1
ifconfig 10.1.0.2 10.1.0.1
log logs/internal-master-to-poller.log
verb 4
mute 20
user nobody
group nobody
script-security 2
```

 

-   Set OpenVPN to autostart

`# chkconfig --level 345 openvpn on`

-   Verify installation

`# service openvpn restart`

Verify that startup is OK.
 If it does not start ok, take a look in log files. These are located in /var/log/openvpn

`# ping 10.1.0.1`

if 10.1.0.1 response the VPN tunnel is working.

## Secure Merlin protocol

Secure Merlin communication by using the internal IP (openvpn) instead of public IP.

-   Master configuration

Open /opt/monitor/op5/merlin/merlin.conf and change your pollers IP to the internal IP 10.1.0.1

-   Poller configuration

Open /opt/monitor/op5/merlin/merlin.conf and change your master IP to the internal IP 10.1.0.2

Restart master and all pollers, run on master

`# mon node ctrl --self --mon restart`

## Comments:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p>The easy-rsa part is outdated in this instruction. From github:<br />&quot;Note that easy-rsa and tap-windows are now maintained in their own subprojects.&quot;<br /><br />Maybe this can help you with the setup:<br /><a href="Secured_and_NAT_aware_communication_between_Master_and_Pollers">Secured and NAT aware communication between Master and Pollers</a></p>
<img src="images/icons/contenttypes/comment_16.png" /> Posted by jsundeen at Feb 21, 2018 06:10</td>
</tr>
</tbody>
</table>


