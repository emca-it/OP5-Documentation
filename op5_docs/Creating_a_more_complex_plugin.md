# Creating a more complex plugin

# About

In this section we will create a more complex and useful plugin compared to the one we created in [Adding your first plugin to OP5 Monitor](Adding_your_first_plugin_to_op5_Monitor). We will use Bash, the standard Linux shell.
We will create a plugin that checks that the storage path specified in '`/etc/op5-backup/main.conf`' exists, to make sure that `op5-backup` is configured properly for local operation.

**Table of Contents**

-   [About](#Creatingamorecomplexplugin-About)
-   [To create a more complex plugin](#Creatingamorecomplexplugin-Tocreateamorecomplexplugin)
-   [More information](#Creatingamorecomplexplugin-Moreinformation)

# To create a more complex plugin

1.  Create the script and edit it:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    # cd /opt/plugins/custom 
    # touch check_op5backup 
    # chmod 755 check_op5backup
    ```

2.  Open up the script with your favorite text editor and type in the following code:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    #!/bin/bash
    # Create a function to print the storage path
    storagepath() {
    grep ^storagepath /etc/op5-backup/main.conf |tail -1 |sed 's/^[^"]*"//g' | sed 's/"$//g'
    }

    # Put the storage path in an environmental variable
    STORAGEPATH=`storagepath`

    # Test if the storagepath exists and is a directory
    if [[ ! -d "$STORAGEPATH" ]]; then
    # Print a warning message for the web gui
    echo op5-backup is not properly configured for local operation
    # Exit with status Warning (exit code 1) 
    exit 1
    fi

    # If the script reaches this point then the test passed
    # Print an OK message
    echo $STORAGEPATH exists
    # Exit with status OK
    exit 0
    ```

    1.  **for Windows admins**

        The above uses 'grep', the global regular expression printer, and 'sed', the stream editor:

         •   'grep' was originally just a feature of an older Unix text editor, 'ex'. If you worked with DOS in the 3.x era, you may have used its sibling, 'edlin'. Unlike edlin, ex is still around. Unix and Linux admins still use its visual mode ('vi') several times a day.

         •   'sed' was designed to deal with streams of text. It's complex enough to be studied as a scripting language of its own. Combine it with 'awk', a formatting language developed by some of the same team that invented C, and you can do amazing things in milliseconds that would take hours with a mouse.

3.  Add a check\_command like this using the OP5 Monitor configuration interface:

    ``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
    command_name: check_op5backup
    command_line: $USER1/custom/check_op5backup
    ```

    ``

4.  Enter the service configuration for your monitor server, and add a service with `check_op5backup` as the check\_command`;`
5.  Save configuration.

# More information

This chapter has only scratched on the surface of how to write your own plugins. To read more about plugin development, take a look at the [guidelines from the Monitoring Plugins Development Team](https://www.monitoring-plugins.org/doc/guidelines.html).

 

