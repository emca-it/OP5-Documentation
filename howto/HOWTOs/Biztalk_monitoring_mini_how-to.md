# Biztalk monitoring mini how-to

Disclaimer

## The plugins in this HOWTO has not been fully tested with all Biztalk versions, for example certain variables or aguments used and available functionality may differ in your environment, please let us know if you have any issues with the plugins or commands mentioned in this HOWTO. All the plugins in this article is shipped with the default op5 Monitor plugins-package.

* * * * *

This mini how-to will show you how to monitor some basic parameters on a Microsoft Biztalk environment. 

### The plugins mentioned in this mini-howto will let you monitor the following in Biztalk:

-   Ports
-   Send ports
-   Queues
-   Location
-   Orchestration
-   Cluster host instance process
-   Spool size
-   Msdtc process

In addition to this it's also possible to monitor Biztalk related metrics and performance counters using NSClient++ and check\_nrpe. Example of how to work with this plugin and performance counter can be found in the end of this how-to.

### **Command definitions to get you started with Biztalk monitoring using our check\_biztalk plugin:
**

-   Monitoring BizTalk ports

 

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
define command{
command_name check_biztalk_ports
command_line $USER1$/check_biztalk -U $USER11$ -P $USER12$ -H $HOSTADDRESS$ -w $ARG1$ -c $ARG2$ -p
}
```

 

-   Command for monitoring Biztalk queues

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
define command{
command_name check_biztalk_queues
command_line $USER1$/check_biztalk -U $USER11$ -P $USER12$ -H $HOSTADDRESS$ -W $ARG1$ -C $ARG2$
}
```

 

-   Specific receive location(s) to check, comma-separated
     

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
define command{
command_name check_biztalk_specific_locations
command_line $USER1$/check_biztalk -U $USER11$ -P $USER12$ -H $HOSTADDRESS$ -w $ARG1$ -c $ARG2$ -l $ARG3$
}
```

 

-   Biztalk orchestration monitoring command
     

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
define command{
command_name check_biztalk_orchestration
command_line $USER1$/check_biztalk -U $USER11$ -P $USER12$ -H $HOSTADDRESS$ -o $ARG1$ -O $ARG2$
}
```

 

-   Monitoring of sendports
     

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
define command{
command_name                   check_biztalk_sendports
command_line                   $USER1$/check_biztalk -U $USER11$ -P $USER12$ -H $HOSTADDRESS$ -d $ARG1$ -D $ARG2$
}
```

### **Command definitions for the check\_biztalk\_cluster\_host\_instance plugin
**

-   Cluster instances running

 

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
define command{
command_name check_biztalk_cluster_host_instance
command_line $USER1$/custom/check_biztalk_cluster_host_instance $ARG1$
}
```

### **Command definition for the check\_biztalk\_msdtc plugin**

-   Check the active instance running
     

 

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
define command{
command_name check_biztalk_msdtc
command_line $USER1$/custom/check_biztalk_msdtc $ARG1$
}
```

 

### **Command definition for performance counters using check\_nrpe and NSClient++
**

-   Checks the spool size of Message Box
     

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
define command{
command_name check_biztalk_spool_size
command_line $USER1$/check_nrpe -H $HOSTADDRESS$ -c CheckCounter -a 'Counter:Spool Size=\BizTalk:Message Box:GeneralCounters(biztalkmsgboxdb:sevmcoinsql)\Spool Size' ShowAll MaxWarn=$ARG1$ MaxCrit=$ARG2$
}
```

Note:

Note: For more performance counters related to Biztalk, please visit [Microsoft Technet](http://msdn.microsoft.com/en-us/library/aa578394.aspx "Biztalk Performance Counter").

 

 

REV 2, 2012-05-07

