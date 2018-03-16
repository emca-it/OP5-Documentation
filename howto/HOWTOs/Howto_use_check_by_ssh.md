# Howto use check\_by\_ssh

-   [Preparation](#Howtousecheck_by_ssh-Preparation)
    -   [To setup the user on the remote host](#Howtousecheck_by_ssh-Tosetuptheuserontheremotehost)
        -   [On the monitor server](#Howtousecheck_by_ssh-Onthemonitorserver)
        -   [On the Monitor server:](#Howtousecheck_by_ssh-OntheMonitorserver:)
        -   [Install the plugin(s)](#Howtousecheck_by_ssh-Installtheplugin(s)Install_the_plugins)
        -   [Disable password for the user on the remote host](#Howtousecheck_by_ssh-DisablepasswordfortheuserontheremotehostDisable_password_for_the_user_on_the_remote_host)
-   [If you are in a distributed/peered environment](#Howtousecheck_by_ssh-Ifyouareinadistributed/peeredenvironment)
-   [Check commands](#Howtousecheck_by_ssh-Checkcommands)
    -   [Adding a new command](#Howtousecheck_by_ssh-Addinganewcommand)
    -   [Adding a new service](#Howtousecheck_by_ssh-Addinganewservice)

Version

This article was written for version 7.x of Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by OP5 Support.

 

Instead of using the NRPE agent and check\_nrpe you can use the plugin called check\_by\_ssh. Almost all Linux installation have ssh enabled. Instead of installing an extra daemon you can use ssh when checking remote systems. This is also useable when you have systems where there simply are no NRPE daemon available but ssh is there.

In this document you will learn what you need to do to get started with `check_by_ssh`.

Use variables when executing the commands

To make things a little bit easier for you we will use a couple of variables in the commands in the document. Set the variables below on command line, in the terminal window, before you start using the commands given in the document. This makes it easier for you so you do not have to change and type in your remote host name and remote user name in each command.

    REMOTE_HOST_NAME=linux01REMOTE_HOST_USER=op5mon

 

We will also use the [Monitoring plugins](https://www.monitoring-plugins.org/), installed via https://fedoraproject.org/wiki/EPEL on a CentOS host. How to install the plugin is described under [Install the plugin(s)](#Howtousecheck_by_ssh-Install_the_plugins).

# Preparation

To be able to use check\_by\_ssh we need to either use an existing user or add a new one on the remote host. We also need to either create a new ssh-key to use for this or we can use an existing one. In this case we will setup a new user on the remote host and create a new ssh-key to be used only for this purpose.

## To setup the user on the remote host

Login to the remote host over ssh as root or as a normal user and get root access.

1.  Create the new user:
    `useradd -m -d /home/${REMOTE_HOST_USER} ${REMOTE_HOST_USER}`A group with the same name as the user name will also be created with the `useradd` command.
2.  Give the user a password by executing:
    `passwd ${REMOTE_HOST_USER}`Can be disabled later on, see Disable password for the user on the remote host.

Setup the ssh-key

### On the monitor server

1.  Login on the monitor server as root or as a normal user and become root.
2.  Become the monitor user:
    `sudo su - monitor`
3.  Create the new ssh-key:
    `ssh-keygen -b 4096 -t rsa -C "monitor@$(hostname) user for check_by_ssh" -N "" -f /opt/monitor/.ssh/id_rsa_check_by_ssh`
    When you are asked for a passphrase for the new ssh-keys do not add a password, just press Enter.
    `Generating public/private rsa key pair.`
    `Your identification has been saved in /opt/monitor/.ssh/id_rsa_check_by_ssh.`
    `Your public key has been saved in /opt/monitor/.ssh/id_rsa_check_by_ssh.pub.`
    `The key fingerprint is:`
    `50:f7:d2:f6:5e:53:03:5f:7d:25:5a:a2:78:88:65:6e monitor@monitor-server user for check_by_ssh`
    `The key's randomart image is:`
    `+--[ RSA 4096]----+`
    `...`
    `+-----------------+`

 

Now we need to add the public key to the remote host.

### **On the Monitor server:**

For the user we created earlier create the .ssh folder and an authorized\_keys file.

1.  Copy the pub key to the remote host
    ssh-copy-id -i /opt/monitor/.ssh/id\_rsa\_check\_by\_ssh \${REMOTE\_HOST\_USER}@\${REMOTE\_HOST\_NAME}
2.  Test the ssh key by connecting over ssh to the remote host:
    asmonitor ssh -i /opt/monitor/.ssh/id\_rsa\_check\_by\_ssh \${REMOTE\_HOST\_USER}@\${REMOTE\_HOST\_NAME}

As `${REMOTE_HOST_NAME}` remember that you need to use the same as you have/will set as "host\_address" in the OP5 Monitor object configuration.

### Install the plugin(s)

If you do not have the plugin(s) installed already this is a short description of how to get them. Make sure you are logged in as the root user on the remote host. Follow the steps below.

1.  Add the EPEL repository
    1.  CentOS 6 and CentOS 7:
        `yum install epel-release`
    2.  RHEL 6:
        `yum install http://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm`
    3.  RHEL 7:
        `yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm `

2.  Install the plugin(s) you need. In this case we will only install check\_disk since we are only using that command in this document.
    `yum install nagios-plugins-disk`

### Disable password for the user on the remote host

If you only want have the possiblity to login as the remote user on the remote hos by using ssh keys, not with password, you can disable the password for the remote user on the remote host. To to do this just execute the following command (as the root user) on the remote host:

    passwd -l ${REMOTE_HOST_USER}

Logout from the remote host.

# If you are in a distributed/peered environment

Remember that you need to make sure that the ssh authentication works from all involved monitor servers. Either copy the ssh-key files to the other involved monitor servers or create new ones for each server.

# Check commands

Now we need to setup the check commands to use. We assume that you have installed the monitoring plugins, mentioned in the beginning of this document. In the exemple below we will use the monitoring plugin check\_disk and setup a service for that.
In the example below we assume that you have the access rights to be able to add commands, hosts and services. You shall already be logged in and are at "Manage -\> Configure" when starting.

## Adding a new command

1.  In "**Manage** -\> **Configure**" click "**Commands**"
2.  Give the command the following name and command line:
    **command\_name:** `check_by_ssh_disk_usage`
    **command\_line:** `$USER1$/check_by_ssh -H $HOSTADDRESS$ -l op5mon -i /opt/monitor/.ssh/id_rsa_check_by_ssh -C "/usr/lib64/nagios/plugins/check_disk -w $ARG1$% -c $ARG2$% -p $ARG3$ -m"`
3.  Click "**Submit**".

## Adding a new service

1.  If the host is already added then pick it up and go to "Services for host ...". If not add the host.
2.  Create a new service and give it the following:
    **service\_description:** `Disk usage /`
    **check\_command:** `check_by_ssh_disk_usage`
    **check\_command\_args:** `15%!10%!/`
3.  Click "**Submit**".

Save the configuration.

 

