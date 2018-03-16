# Monitoring and graphing OP5 Environmental Monitor EM1

## **Introduction**

The Sensatronics model EM1 is part of the OP5 Environment Starter Packs and sold separately under the name OP5 Environmental Monitor EM1. This how-to describes how to set up monitoring of the environmental module in OP5 Monitor.

## **Prerequisites**

-   OP5 Monitor installed correctly
-   Sensatronics EM1 set up in accordance with the OP5 Environment module manual or the accompanying Sensatronics Model EM1 Environmental Monitor Quick Start Guide.
-   HTTP network access from the OP5 server to the environmental monitor.

## **Configuring OP5 Monitor**

Verify that your configuration contains the following commands:

    check_snmp_em1_humidity

    check_snmp_em1_temperature

    check_snmp_em1_wetness

If the commands are missing in your configuration you can add the using the Check Command Import function located under ‘Configure’ -\> ‘Check Command Import’.

Add a new host object for your EM1, an example follows below:

    host_name: environment-sth

    alias:  OP5 Environmental Monitor EM1

address: env1-sth.int.op5.se

    Management protocol: http

Add services for temperature and/or humidity, examples follows below:

    service_description: Temperature – Server

    check_command: check_em1_temperature

    check_command_args: 1!23.2:25.4!15:30 (sensor unit, warning threshold, critical threshold)

(Thresholds support ranges and decimal points)

 

    service_description: Humidity – Server

    check_command: check_em1_humidity

    check_command_args: 1!40:60!35:65

## **Configuring OP5 Statistics**

 

op5 Statistics is deprecated, this part of the article is kept for historical purpose only.

 

Add a new device (or export it from Monitor using ‘Configure’ -\> ‘Export hosts to Statistics’), an example follows below:

Description: environment-sth

Hostname: 172.27.76.22 (!must be an IP-adress, hostname currently not supported for environmental modules)

Host Template: Sensatronics EM1SNMP

Community: public

Verify connectivity to your new device by looking at the SNMP Information in top of the page.

Create graphs for your new device by clicking ‘Create Graphs for this Host’, selecting the Graph Templates you want to use and clicking ‘create’. Set the appropriate sensor unit number and click ‘create’ again. Verify that the graphs were created successfully by looking at the top of the page.

Add your device or individual graphs to a Graph Tree by clicking ‘Graph Trees’, selecting the tree and branch were you want the graphs to be located, clicking ‘Add’, selecting Tree item type ‘Host’ or ‘Graph’, selecting the host/graph you want to add and clicking ‘create’. Your newly added graph should be displaying data within 15 minutes (3 poller cycles).

 

