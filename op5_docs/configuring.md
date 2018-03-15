# configuring

# Introduction

There are two supported ways to change the configuration of your OP5 Monitor:

-   Using the web UI OP5 Monitor configuration tool;
-   Using the REST API.

We will discuss the API as a configuration tool in a later chapter. This chapter will take a look at how to use the OP5 Monitor Configuration tool, which henceforth we will call **Configure**.

# Caveat

OP5 does not support editing configuration files directly!

Editing OP5 configuration files directly (in other words: in '/opt/monitor/etc' on the OP5 server) ***is not supported!***

OP5 Monitor uses Livestatus to parse the configuration files based on a temporary save file and a comparison to the database content. Any manual edits could conflict with Livestatus data as well as anything passed to the API.

We need to make this as clear as possible. Many people reading this Guide may come from Nagios administration, where editing the configuration files and creating new files are commonplace. We beg of you to leave these files alone. Please let our complex of miniature databases serve your higher goals.

# Workflow

Most of the configuration in op5 Monitor is saved in configuration files (text files) in /opt/monitor/etc/. The Configure works with a database and this makes it possible to do changes in the configuration without saving it to file before all configuration is done. The table below describes the workflow:

**Step**

**Description**

1

You (as an admin) open Configure.

2

This triggers Livestatus to compare the config files and the Nacoma database content:

-   If the config file are newer than any Nacoma content, Livestatus will import the changes to Nacoma before opening the Configure page.
-   If the config files are not newer than Nacoma content, then Configure opens right up.

3

You edit configuration objects: hosts, services, contacts, groups, templates, commands.

4

Click the **Submit** button at the bottom of the object just added or changed.

5

Edit or create another configuration object.

6

Once you finish editing the configuration objects for a session, save the Configure database to the configuration files by clicking **Save**.

7

Livestatus runs a pre-flight check to verify the configuration changes before exporting them to the configuration files:

-   If this check fails, the admin sees an error message and nothing gets exported.
-   Otherwise, Livestatus exports the configuration in the database to the config files.

8

Naemon, the main engine of OP5 Monitor, restarts. It also runs a verification ("`naemon -v /opt/monitor/etc/naemon.cfg`") as it restarts and loads the configuration files.

9

Naemon triggers Merlin to synchronize with pollers and peers.

