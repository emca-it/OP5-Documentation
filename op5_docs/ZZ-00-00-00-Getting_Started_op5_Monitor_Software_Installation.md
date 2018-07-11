# Getting Started: OP5 Monitor Software Installation

Version

This article was written for version 7.2 of Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by OP5 Support.

This document applies to the installable software version of OP5 Monitor. For information on the setting up the VM version, refer to the quick start guide here.

1. Download software package to target Linux system running CentOS 6.6/RHEL 6. ([Download Link](https://www.op5.com/download-op5-monitor/))
2. Log in via SSH or by accessing the terminal on the target system.
3. Change user to root (password required):

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    su -
    ```

4. Navigate terminal to the folder containing the downloaded package, and move it to /root

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    mv op5-monitor*.tar.gz /root
    ```

5. Navigate to /root

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    cd /root
    ```

6. Unpack (file name will vary by version, \* indicates a wildcard)

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    tar -xzf op5-monitor*.tar.gz
    ```

7. Navigate to unpacked folder (folder name will vary by version, \* indicates a wildcard)

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    cd op5-monitor*
    ```

8. (OPTIONAL) View included readme using preferred text editor (nano, vi, gedit)

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    nano
    ```

9. In terminal, view directory contents to confirm install.sh & install.py are executable

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    ls -l
    ```

    1.  If not executable, issue the following command:

        ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
        chmod +x install.sh && chmod +x install.py
        ```

10. Execute install script

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    ./install.sh
    ```

11. Reboot

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    reboot
    ```

12. After reboot, use your browser and browse to the server, use the following address:
    https://\<IP or hostname\>/monitor
13. You will be prompted to create an account with administrator privileges the first time you access OP5 Monitor. Save the login credentials at a safe location so that the account is not lost.
    ![](images/17661962/17858614.png)
