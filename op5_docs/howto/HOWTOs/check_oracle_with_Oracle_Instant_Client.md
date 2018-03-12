# check\_oracle with Oracle Instant Client

**Introduction**

This how-to describes how to setup your op5 Monitor server with Oracle Instant Client to be able to use the plugin check\_oracle directly towards the Oracle Database. This means we eliminate the use of 3rd party agents on the server, and it’s the same syntax for Linux/UNIX and Windows platforms. In this how-to we will use version 11.2.0.2.0.6 of Oracle Instant Client. The 11-series client works for checks against Oracle 11 and Oracle 10 databases. The word ‘\<shell\>\#’ means that you will need to type a command in the command line interface.

## **Requirements**

-   Oracle Instant Client installed on your op5 Monitor server.

-   A user with sufficient access to the databases you want to monitor is needed. The user needs the following permissions:

**User rights**

``` {.sql data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence"}
create user <USER> identified by <PASSWORD>;
grant create session to <USER>;
grant select any dictionary to <USER>;
grant select on V_$SYSSTAT to <USER>;
grant select on V_$INSTANCE to <USER>;
grant select on V_$LOG to <USER>;
grant select on SYS.DBA_DATA_FILES to <USER>;
grant select on SYS.DBA_FREE_SPACE to <USER>;
```

**Oracle Instant Client**

1.  Begin by logging on to your op5 Monitor server via SSH.
     
2.  The Oracle Instant Client should be installed by default in your op5 Monitor setup. To make sure, execute the command below, which will install the needed packages if they are missing.
    `# yum install oracle-instantclient11.2-sqlplus oracle-instantclient11.2-devel`
3.  A set of environment variables are needed, both for the shell and Nagios/Naemon. Set this up by creating the file */etc/profile.d/*check\_oracle.sh** with the following contents:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    export ORACLE_HOME=/usr/lib/oracle/11.2/client64
    export TNS_ADMIN=/etc
    export LD_LIBRARY_PATH=$ORACLE_HOME/lib
    PATH=$PATH:$ORACLE_HOME/bin
    ```

    In case of running op5 Monitor version 7.0.5.2 or later, make sure that the same data as seen above is also found in the file */etc/sysconfig/naemon*.

4.  Now log out the current SSH session, and then log on again.
5.  Verify that the environment variables were properly read at log-on by printing their content into the terminal:
    `# echo $ORACLE_HOME`
    `# echo $TNS_ADMIN`
    `# echo $LD_LIBRARY_PATH `
6.  Install SQL\*Plus and configuration files.
    `# ln -s $ORACLE_HOME/sqlplus /usr/bin/sqlplus`
    `# touch $TNS_ADMIN/sqlnet.ora`
    `# touch $TNS_ADMIN/tnsnames.ora `
7.  Edit /etc/tnsnames.ora according to your Oracle Environment.

    **tnsnames.ora sample**

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    OP5= (DESCRIPTION =
          (ADDRESS_LIST =
                    (ADDRESS = (PROTOCOL = TCP)
            (HOST = oracle.op5.com)(PORT = 1521)))
     (CONNECT_DATA =
            (SID = op5)))
    ```

    **tnsnames.ora - Sample 2**

    ``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
    OP5= 
        (DESCRIPTION =
            (ADDRESS = (PROTOCOL = TCP)(HOST = oracle.op5.com)(PORT = 1521))  
            (CONNECT_DATA =
                (SERVER = DEDICATED)
                (SERVICE_NAME = op5service) 
            )
        )
    ```

     

    If you need more information on how to set up this file, please consult your Oracle administrator.

8.  You should now be able to connect to you database with the following command:
    `# sqlplus <user>/<password>@op5`

## **Perl support**

Not required for check\_oracle.pl

To write own plugins and use DBI to connect to Oracle you need to have all the above steps working.
Install gcc and then proceed with installing DBD::Oracle from CPAN.

    # yum install gcc

    # perl -MCPAN -e 'install DBD::Oracle'

DBI support with DBD::Oracle module is now installed.

**
**

**Getting tnsping to work**

 

The following steps are not supported by op5 or Oracle, but are known to work. If you are having problem though, you could also use the dummy login test instead. (check\_oracle -l \<SID\>)

 

To get tnsping to work you have to copy tnsping and tnsus.msb from an existing Linux Oracle installation, preferably from an RedHat 4/5 Installation. put the file in \$ORACLE\_HOME.

Place tnsping in /usr/lib/oracle/11.2/client64/tnsping
Place tnsus.msb in /usr/lib/oracle/11.2/client64/network/mesg/tnsus.msb

Make sure you have read permission to tnsus.msb for user “monitor”

 

Create symlinks to get tnsping to work:

    # ln -s $ORACLE_HOME/tnsping /usr/bin/tnsping
    # cd /usr/lib/oracle/11.2/client64
    # ln -s lib/libclntsh.so.11.1 libclntsh.so.10.1
    # ln -s lib/libnnz11.so libnnz10.so

Verify that your tnsping is working.

    # tnsping op5
    Attempting to contact (DESCRIPTION = (ADDRESS_LIST = (ADDRESS =
    (PROTOCOL = TCP)(HOST = oracle.op5.com)(PORT = 1521)))
    (CONNECT_DATA = (SID = op5)))
    OK (40 msec)

**
**

**Restart Monitor**

The last thing you need to do is to restart op5 Monitor. This is done with the following command:

    # service naemon restart

# OP5 Monitor: Open Source Network Monitoring

[OP5 ](https://www.op5.com/)is the preferred Open Source Networking & Server Monitoring tool for large multi-national companies in over 60 markets. If you would like to experience OP5 Monitor you can get started here, alternatively, if you prefer to get more hands on you can Download OP5 Monitor for free. 

 

 

