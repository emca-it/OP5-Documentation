# Monitor Cisco UCS Blade chassi

Version

This article was written for version 6.1.2 of Monitor, it could work on both lower and higher version if nothing else is stated. check\_ucs is not a official supported plugin from op5.

# Introduction

This how-to describes how to monitor a Cisco UCS Blade chassi.
There is no plugin for UCS monitoring included in the product, so this has to be downloaded and installed as a custom plugin.

This plugin can monitor

- Chassi Temperature
- Chassi Fans Status
- Chassi Power Supplies Status
- IO Card Status
- Fault summary from UCS Manager

# Prerequisites

- Shell access to the host running *op5 Monitor*
- A read-only SNMP community configured in the UCS manager

# Installation

1. Download [this](attachments/3801462/4358163) file to the "/opt/plugins/custom" directory:

    ``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
    # wget -O /opt/plugins/custom/check_ucs https://kb.op5.com/download/attachments/3801462/check_ucs
    ```

2. Make the file executable:

    ``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
    # chmod 755 /opt/plugins/custom/check_ucs
    ```

# Command configuration

If you don't wish to configure the commands manually, you can use the [community contributed management pack](https://kb.op5.com/download/attachments/4653615/Cisco%20UCS%20Chassi.json?api=v2)

1. Go to OP5 Monitor Configuration | Commands
    ![](attachments/3801462/4358164.png)

2. Create 5 check commands:

    Name

    Command

    check\_ucs\_temp

    \$USER1\$/custom/check\_ucs -H \$HOSTADDRESS\$ -C \$ARG1\$ -T ct -N \$ARG2\$

    check\_ucs\_fan\_status

    \$USER1\$/custom/check\_ucs -H \$HOSTADDRESS\$ -C \$ARG1\$ -T f -N \$ARG2\$

    check\_ucs\_iocard\_status

    \$USER1\$/custom/check\_ucs -H \$HOSTADDRESS\$ -C \$ARG1\$ -T ci -N \$ARG2\$

    check\_ucs\_PSU\_status

    \$USER1\$/custom/check\_ucs -H \$HOSTADDRESS\$ -C \$ARG1\$ -T po -N \$ARG2\$

    check\_ucs\_fault\_summary

    \$USER1\$/custom/check\_ucs -H \$HOSTADDRESS\$ -C \$ARG1\$ -T fs

3. Add these 5 check commands as services to the UCS chassi host with the check command arguments below.We assume that the SNMP community name is 'public' and the chassis name is 'chassis-1', check you names in the UCS Manager:

    Service Description

    Check command

    Check command Arguments

    Chassi Temperature

    check\_ucs\_temp

    public!chassis-1

    Fan Status

    check\_ucs\_fan\_status

    public!chassis-1

    IO Card Status

    check\_ucs\_iocard\_status

    public!chassis-1

    Power Supply Status

    check\_ucs\_PSU\_status

    public!chassis-1

    Fault Summary

    check\_ucs\_fault\_summary

    public

4. Save your configuration
