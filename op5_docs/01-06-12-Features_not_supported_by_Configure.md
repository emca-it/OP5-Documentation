# Features not supported by Configure

## About

Even though some features are not supported by the OP5 Monitor configuration tool you can still use them.
The `hostgroup_name` is one of them.
What you have to do is to add a separate configuration file not read by the import function in Configure. Then you add your other configuration tricks into that file.

## To add a configuration file not read by Configure

1. Open up a ssh connection to the OP5 Monitor server and login as root.
1. Create the following file with an editor of your choice:

    `/opt/monitor/op5/nacoma/custom_config.php`

1. Add the following code to the file you just created:

    ``` {.php}
    <?php
    $notouch_file_prefix = "_";
    ?>
    ```

1. Create a configuration file with "\_" as a prefix to the file name like this:

    `touch /opt/monitor/etc/_custom_objects.cfg`

1. Add the file to the /opt/monitor/etc/nagios.cfg with by adding the following line below the other cfg\_file variables in nagios.cfg:

    `cfg_file=/opt/monitor/etc/_custom_objects.cfg`

1. Restart OP5 Monitor.

    `service monitor restart`

Now you may add your objects to the new configuration file and they will not be loaded into Configure. But you can still see the objects using View config as it is described in the OP5 Monitor user manual.
