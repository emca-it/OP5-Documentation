# Features not supported by Configure

# About

Even though some features are not supported by the op5 Monitor configuration tool you can still use them.
The `hostgroup_name` is one of them.
What you have to do is to add a separate configuration file not read by the import function in Configure. Then you add your other configuration tricks into that file.

**Table of Content**

-   [About](#FeaturesnotsupportedbyConfigure-About)
-   [To add a configuration file not read by Configure](#FeaturesnotsupportedbyConfigure-ToaddaconfigurationfilenotreadbyConfigure)

# To add a configuration file not read by Configure

-   -   Open up a ssh connection to the op5 Monitor server and login as root.
    -   Create the following file with an editor of your choice:

            /opt/monitor/op5/nacoma/custom_config.php

    -   Add the following code to the file you just created:

        ``` {.php data-syntaxhighlighter-params="brush: php; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: php; gutter: false; theme: Confluence"}
        <?php
        $notouch_file_prefix = "_";
        ?>
        ```

    -   Create a configuration file with "\_" as a prefix to the file name like this:

            touch /opt/monitor/etc/_custom_objects.cfg

    -   Add the file to the /opt/monitor/etc/nagios.cfg with by adding the following line below the other cfg\_file variables in nagios.cfg:

            cfg_file=/opt/monitor/etc/_custom_objects.cfg

    -   Restart op5 Monitor.

            service monitor restart

Now you may add your objects to the new configuration file and they will not be loaded into Configure. But you can still see the objects using View config as it is described in the op5 Monitor user manual.

