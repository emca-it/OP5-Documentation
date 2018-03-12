# Integrating op5 Monitor authentication with Active Directory

Microsoft Active Directory is used to share user list, provide single sign on and other central features in large Microsoft based workstation and server networks. Active Directory is Microsoft’s implementation of existing business standards such as LDAP, Kerberos and DNS. The purpose of this article is to provide a step by step guide on how to integrate op5 Monitor authentication with Active Directory.

 

This is a legacy document and does not apply to op5 Monitor 6.0 or later versions. Please read: [Active Directory Integration How-To](Active_Directory_Integration_How-To) for op5 Monitor 6.0.

## Prerequisites

To be able to complete this how-to you will need:

-   op5 Monitor 5.7 or below.
-   Administrator access to a working Active Directory environment.
-   Root command line access to a running op5 Monitor.

## This will be done

Make op5 Monitor security system use Active Directory as its authentication source.

## Prepare Active Directory

Before configuring op5 Monitor, we need to set up a user op5 Monitor can use to read authentication data from Active Directory, and an Admin group for the op5 Monitor itself.

-   Create a normal user, for example op5auth.
-   Create a global group for admin rights to op5 Monitor, for example op5admins.

## Configure op5 Monitor

For the next steps, you will need root access to the machine running op5 Monitor, either via console, or ssh. Also worth noting for this exercise, our lab DC has IP-address 192.168.1.97 and it is running a pretty much out-of-the-box Active Directory structure with domain name op5.com and all users reside in the OU Users.

Log on as root on op5 Monitor and start the configuration script:

`[root@monitor01 ~]# op5-authconfig`

Now a series of questions will be asked, answer yes to the first question about converting from the old op5 auth system, then chose ad as authentication method.

Below are the rest of the questions and answers provided for our lab environment.

-   LDAP Server 192.168.1.97
-   LDAP Search base dc=op5,dc=com
-   Where are your user DN:s? cn=Users,dc=op5,dc=com
-   In what subtree are your groups located? cn=Users,dc=op5,dc=com
-   Group for admin access op5admins
-   Username for the server to connect to AD <with%C2%A0op5auth@op5.com>
-   Enter bind password op5auth’s password
-   Finally, accept the change to your authentication config.

Make sure the configuration file looks ok.

    [root@monitor01 ~]# cat /etc/httpd/conf.d/op5ldapauth.conf

      

    AuthzLDAPServer 192.168.1.97

    AuthzLDAPUserBase cn=Users,dc=op5,dc=com

    AuthzLDAPGroupBase cn=Users,dc=op5,dc=com

    AuthzLDAPUserKey sAMAccountName  

    AuthzLDAPBindDN op5auth@op5.com  

    AuthzLDAPBindPassword l4bp4SSw0rD

    require valid-user

    AuthzLDAPUserScope subtree

    AuthType basic

    AuthzLDAPMethod ldap AuthName "OP5 Monitor Access"

## Known bugs and limitations

Please refrain from using spaces in the admin group name, as this can cause problems.If your admin group and users reside in an OU containing spaces in its name, you will need to manually edit two files after accepting the new configuration. Let’s say our admin group op5admins is located in the OU op5 Operators, the values forAuthzLDAPUserBase and AuthzLDAPGroupBase in /etc/httpd/conf.d/op5ldapauth.conf need to be enclosed in double quotes:

    AuthzLDAPUserBase "ou=op5 Operators,dc=op5,dc=com"

    AuthzLDAPGroupBase "ou=op5 Operators,dc=op5,dc=com"

You also need to edit /opt/op5sys/etc/ldapserver and make sure the values for LDAP\_GROUP andLDAP\_USERS are not enclosed in single quotes, if they are – remove the quotes:

    LDAP_GROUP=ou=op5 Operators,dc=op5,dc=com

    LDAP_USERS=ou=op5 Operators,dc=op5,dc=com

 

 

