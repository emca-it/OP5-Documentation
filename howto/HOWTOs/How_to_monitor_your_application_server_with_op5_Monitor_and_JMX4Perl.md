# How to monitor your application server with OP5 Monitor and JMX4Perl

In this how-to we will cover how to monitor your application server via [JMX](http://en.wikipedia.org/wiki/Java_Management_Extensions "JMX") with OP5 Monitor with the plugin check\_jmx4perl and the agent jolokia. We will also have a glance at monitoring application  servers trough a JMX-proxy for agentless monitoring where agents are not possible to use.

Version disclaimer

This article is written for OP5 Appliance System 3.5.2 and OP5 Monitor 5.4.3, and should work for versions up to 5.7.3 of OP5 Monitor. This article does not apply to OP5 Appliance System 6.0 and OP5 Monitor 6.0 and later.

## Prerequisites

 In this example the community version of Jboss 6 is used as the server of choice.  Make sure that you have Perl, gcc and make installed, and the necessary ports opened in your firewall. Basic UNIX/Linux knowledge is needed.

## Additional Information

JMX4Perl: <http://labs.consol.de/lang/de/jmx4perl/>

Agent information: <http://www.jolokia.org/reference/html/agents.html>

Proxy information: <http://www.jolokia.org/reference/html/proxy.html>

Security configuration:<http://www.jolokia.org/reference/html/agents.html#agent-war-security>

## Disclaimer

This how-to  is not officially supported by op5. It is just a glimpse on how to preform monitoring of application servers with OP5 Monitor. And I am not a sysadmin working with application servers all day long, so there may be some glitches here and there. This is not a security document, so it is your responsibility that your system is secure. Please refer to the developers [manual](index "manual") for more information about securing your installation.

## Installation

If you run a distributed and/or Load Balanced setup, you will need to install the plugin on all systems that are running jmx-checks.

 When using a agentless approach these steps only applies for the server that is acting as proxy.

- Download JMX4Perl

You can fetch the latest version from: <http://search.cpan.org/dist/jmx4perl/>

- Extract the file:

<!-- -->

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
tar xvzf jmx4perl*.tar.gz
cd jmx4perl-Configuration
perl Build.PL
```

This command will most likely complain about the following dependencies: CBuilder, ParseXS and Module-Build.

Install them via rpm as described below. We have collected these RPM’s on our download site for your convenience.

- Download and unpack the attached dependency package [here](attachments/688604/5242978.gz)

**Download and unpack**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
 tar xvzf jmx4perl_dependencies.tar.gz
```

- Installation

**Installation**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
rpm -Uvh perl-ExtUtils-ParseXS*.rpm
rpm -Uvh perl-ExtUtils-CBuilder*.rpm
rpm -Uvh perl-Module-Build*.rpm
```

Now it’s time to choose which components to install from the jmx4perl-package.

The required components are jmx4perl, and check\_jmx4perl, although we recommend to install “j4psh” which is a JMX-shell that you can connect to JBoss and browse around the MBeans.

- Re-run Build.pl

**Build.PL**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
perl Build.PL
Install 'jmx4perl' ? (y/n) [y ]y
Install 'check_jmx4perl' ? (y/n) [y ]y
Install 'cacti_jmx4perl' ? (y/n) [y ]n
Install 'j4psh' ? (y/n) [y ]y
Use Term::ReadLine::Gnu ? (y/n) [n ]n
Install 'jolokia' ? (y/n) [y ]n
```

When this is done there may still be some missing dependencies and the Build-script will try to install these by itself.

Run the following commands:

**Build**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
./Build installdeps
./Build
./Build test
./Build install
```

If all goes well you should have JMX4Perl installed on your system.

## Deployment of webapp

Next we will need to deploy the webapp “jolokia” in our Application server. In this example I used Jboss6.

 You can also install Jolokia via the JMX4Perl installer by selecting “y” for the jolokia option.

 the latest version of Jolokia can be found at: <http://www.jolokia.org/download.html>

**jolokia**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
ssh root@jboss-server
wget <link to jolokia-war*.war>
mv jolokia-war-0.91.war jolokia.war
cp jolokia.war /home/jboss/jboss-6.0.0.Final/server/default/deploy
```

Now the web-app is deployed, and JBoss will extract it by it self.

To test if the web-app works, browse to: http://:/jolokia/version

or run the following command from your OP5 Monitor server:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
jmx4perl http://:/jolokia
```

Now jmx4perl should return some information about JBoss and jolokia.

You can also connect with j4psh-shell to the server and browse around the MBeans:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
j4psh http://:/jolokia
```

- Copying files

You need to copy the installed check\_jmx4perl and it’s config-files to a directory that OP5 Monitor can browse:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
mkdir /opt/plugins/custom/jmx4perl
cp /usr/bin/check_jmx4perl /opt/plugins/custom/jmx4perl/
```

- Test check\_jmx4perl

Now we can try to do a check in command-line using this example:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
cd /opt/plugins/custom/jmx4perl/
./check_jmx4perl -u http://:/jolokia --alias MEMORY_HEAP_USED --base MEMORY_HEAP_MAX --warning 80 --critical 90
```

That should give a output similar to this:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
OK - [MEMORY_HEAP_USED] : In range 23.82% (123159632 / 517013504) | [MEMORY_HEAP_USED]=123159632;413610803.2;465312153.6;0;517013504
```

## Config files

First copy all the default configs to your created “jmx4perl” folder in /opt/plugins/custom/jmx4perl/

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
cd /root/jmx4perl-0.95 jmx4perl-0.95/
cp -R config/ /opt/plugins/custom/jmx4perl/
```

- One config to rule them all

In this example we will create one config that includes all the others to make changes more simple to maintain and to shorten the check commands.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
cd /opt/plugins/custom/jmx4perl/
```

Create this config called jmx4perl.cfg:

**jmx4perl.cfg**

``` {.plain data-syntaxhighlighter-params="brush: plain; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: plain; gutter: true; theme: Confluence"}
# Default definitions
include memory.cfg
#include tomcat.cfg #Is included in jboss.cfg
include jboss.cfg
include threads.cfg
# ====================================
# Check definitions

Use memory_heap
Critical 90
Warning 80

Use thread_count
Critical 1000
Warning 800

# Check for uptime, used as kind of 'ping' for
# service dependencies

MBean java.lang:type=Runtime
Attribute Uptime
Warning 120:
Critical 60:

# A multi check combining two checks

Check j4p_memory_heap
Check j4p_thread_count
```

These files contains the variables set in “check\_command\_args” for the check commands that we will create.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
cd /opt/plugins/custom/jmx4perl/config/
ls
common.cfg jboss.cfg jetty.cfg jmx4perl.cfg memory.cfg threads.cfg tomcat.cfg
```

I will go trough: memory.cfg, thread.cfg and some possibilities to customize your jboss.cfg.

Please have a look in the config files for further explanation of the options.

- memory.cfg

Command variable

Explanation

memory\_heap

Relative Heap Memory used by the application.

memory\_non\_heap

Relative non-heap memory.

memory\_pool\_base

Memory pool checks, specific to a Sun/Oracle JVM.

- threads.cfg

Command name

Explanation

thread\_inc

Check for a thread increase per minute

thread\_count

Check for monitoring the total (absolute) count of threads

thread\_deadlock

Find deadlocked Threads

## Check commands

- Using agents

First we create check commands to be used with agents. You can read the pros and cons for the different usages of jolokia at:

<http://www.jolokia.org/reference/html/architecture.html#agent-mode> and <http://www.jolokia.org/reference/html/architecture.html#proxy-mode>

When using config-files we minimize the number of check commands to a bare minimum, and we will only create two of them.

One for static checks and one for an incremental check that shows how much a value has changed in a given time period.

- Go to: Configure -\> Commands

Create a new check command with the following values:

**command\_name**

**command\_line**

check\_jmx4perl\_config

\$USER1\$/custom/jmx4perl/check\_jmx4perl -u http://\$HOSTADDRESS\$:\$ARG1\$/jolokia –config \$USER1\$/custom/jmx4perl/config/jmx4perl.cfg –check \$ARG2\$ –warning \$ARG3\$ –critical \$ARG4\$

- Click “Apply Changes”

And the same procedure for the incremental check:

**command\_name**

**command\_line**

check\_jmx4perl\_config\_delta

\$USER1\$/custom/jmx4perl/check\_jmx4perl -u http://\$HOSTADDRESS\$:\$ARG1\$/jolokia –config \$USER1\$/custom/jmx4perl/config/jmx4perl.cfg –check \$ARG2\$ –delta \$ARG3\$ –warning \$ARG4\$

And finally, save the changes.

First we add host to OP5 Monitor with the ip-address of our application server.

- Go to: Configure -\> New Host

Fill in the configuration information: host name, alias, address etc.

- Click “Scan host for services” -\> Click “Continue to step 3″

- Next, click “Services for”

Select the check command that you just created, and fill in the following arguments:

- Go to the host -\> Services -\> Add new service

The separators of check\_command\_args are: "**!**"

**service\_description**

**check\_command**

**check\_command\_args**

JMX4Perl – HeapMemoryUsage

check\_jmx4perl\_config

8080!memory\_heap!70!90

- Click “Apply Changes”

And Save applied changes

Repeat these steps for the incremental check

**service\_description**

**check\_command**

**check\_command\_args**

JMX4Perl – HeapMemoryUsageDelta

check\_jmx4perl\_config\_delta

8080!memory\_heap!300!25

This command checks how much memory usage has changed the last 5 minutes (300 seconds), with a warning threashold of 25%.

## Proxy mode

When using a agentless approach we need a app-server with the jolokia webapp installed, and configured to accept connections via RMI.

This was default on my installation of Jboss6 and i won’t expand it any further.

RMI test:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
cd /opt/plugins/custom/jmx4perl
./check_jmx4perl -u http://:/jolokia --target service:jmx:rmi:///jndi/rmi://:port/jmxrmi --config config/jmx4perl.cfg --check memory_heap --warning 80 --critical 90
```

If this works you should get something like this in return:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
OK - Heap-Memory: 25.79% used (127.18 MB / 493.06 MB) | Heap=133359304B;413610803.2;465312153.6;0;517013504
```

Now we will create a check command using config-files as explained earlier.

- Check command:

**command\_name**

**command\_line**

check\_jmx4perl\_config\_proxy

\$USER1\$/custom/jmx4perl/check\_jmx4perl -u http://\$ARG1\$:\$ARG2\$/jolokia –target service:jmx:rmi:///jndi/rmi://\$HOSTADDRESS\$:\$ARG3\$/jmxrmi –config \$USER1\$/custom/jmx4perl/config/jmx4perl.cfg –check \$ARG4\$ –warning \$ARG5\$ –critical \$ARG6\$

First we add host to OP5 Monitor with the ip-address of our application server.

- Go to: Configure -\> New Host

Fill in the configuration information: host name, alias, address etc. Click “Scan host for services” -\> Click “Continue to step 3″

- Next, click “Services for”

Select the check command that you just created, and fill in the following params:

**service\_description**

**check\_command**

**check\_command\_args**

Heap Memory Via Proxy

check\_jmx4perl\_config\_proxy

!8080!1090! memory\_heap!80!90

Argument explanation:

First we define which host that runs the JMX-proxy, port, rmiport on the actual server we want to monitor, what checks we want to run on this server, and finally the thresholds.

These arguments is also listed in the config-files for jmx4perl just as the previous example with agents.

What you want to monitor in your environment is your call, this is just a glance at the possibilities using jmx4perl.

### Jboss Labs (Optional)

This part shows some custom options that are not covered with the default configuration and is entirely optional. I just want to show examples for custom checks that you can create and include in your configs according to your needs. I found these values using the “j4psh” shell and browsing around the MBeans and editing jboss.cfg according to the MBean names and creating check commands for these:

- jboss.cfg

**Command Name**

**Explanation**

jboss\_cpool\_available

Available connections in a connection pool for a data source

    MBean = jboss.jca:name=JmsXA,service=ManagedConnectionPool
    Attribute = AvailableConnectionCount
    Name = Avalible Connections

**Command Name**

**Explanation**

jboss\_cpool\_used\_max

The reverse: Max. number of connections ever in use

    MBean = jboss.jca:name=JmsXA,service=ManagedConnectionPool
    Attribute = MaxConnectionsInUseCount
    Name = Max. connections in use

**Command Name**

**Explanation**

jboss\_cpool\_used

Connections currently in use

    MBean = jboss.jca:name=JmsXA,service=ManagedConnectionPool
    Attribute = InUseConnectionCount
    Name = Connections in use

**Command Name**

**Explanation**

jboss\_cpool\_creation\_rate

Rate how often connections are created per minute

    Use = count_per_minute("connections")
    MBean = jboss.jca:name=JmsXA,service=ManagedConnectionPool
    Attribute = ConnectionCreatedCount
    Name = Connection creation rate

You can of course create additional config files with your specific needs and include them in “jmx4perl.cfg”
