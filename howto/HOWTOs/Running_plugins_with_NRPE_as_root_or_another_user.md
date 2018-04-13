# Running plugins with NRPE as root or another user

## Introduction

This how-to describes how to make NRPE execute scripts as another user, like *root* or *backupadmin*. This can be useful for plugins that control system services and similar.

It's not recommended to run check plugins or other scripts with NRPE as root - passing non-sanitized arguments to a script could result in arbitrary code execution with system level privileges.
Use the following guide with caution!

## Prerequisites

You will need the application *sudo*, root access to the system and basic UNIX knowledge. The commands below show you how to install *sudo* on RHEL and Debian-based Linux distributions:

**On RHEL-based distributions**

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# yum install -y sudo
```

**On Debian-based distributions**

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# apt-get install -y sudo
```

##
sudo configuration

We will start by checking which user the NRPE daemon runs as:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# grep "nrpe_user=" /path/to/nrpe.conf
nrpe_user=nrpeuser
```

Run the *sudo* configuration tool *visudo*:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# visudo
```

You might get prompted to select a text editor - select your editor of choice and continue.

Add the row below under "Defaults specification" to enable execution of *sudo* commands without a TTY:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
Defaults: nrpeuser !requiretty
```

Create a new row and add **one** of the following lines to enable password-less execution of specified command as root or another user:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# Allows running a script as root without any arguments
nrpeuser    ALL=(root)  NOPASSWD: /path/to/script ""

# Allows running a script as root with fixed arguments
nrpeuser    ALL=(root)  NOPASSWD: /path/to/script --option-1 "a" --option-2 "b"

# Allows running a script as root with any arguments
# THIS COULD BE DANGEROUS AND IS _NOT_ RECOMMENDED
nrpeuser    ALL=(root)  NOPASSWD: /path/to/script
```

Save and exit the text editor to close the *visudo* utility.

Listing sudo permissions

You can use the "sudo -l" command as the user running NRPE to list allowed commands.
This can help you debug issues - some characters needs to be escaped when used with sudo and similar

## NRPE configuration

Open a NRPE commands configuration file (for example */etc/nrpe.d/custom.cfg*) with your text editor of choice and prefix desired command with *sudo*:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# Commands with arguments in quotes needs to be escaped with a backslash
command[check_example]=/usr/bin/sudo /path/to/script --option-1 \"a\" --option-2 \"b\"
```

Save and exit the text editor.

After restarting the NRPE daemon you should now be able to run scripts with NRPE as another user!

# OP5 Monitor: Open Source Network Monitoring

[OP5 ](https://www.op5.com/)is the preferred Open Source Networking & Server Monitoring tool for large multi-national companies in over 60 markets. If you would like to experience OP5 Monitor you can get started here, alternatively, if you prefer to get more hands on you can Download OP5 Monitor for free.
