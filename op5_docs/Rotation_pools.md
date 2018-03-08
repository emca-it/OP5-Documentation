# Rotation pools

# About 

The Rotation pools are just sets of NagVis maps that are used to rotate between. So you can open up a rotation pool to have your maps shown for a certain time and then the rotate function will switch to the next map in the pool.
There is no GUI to use for administration of the rotation pools so this will require editing the configuration file from the command line.

**Table of Content**

-   [About ](#Rotationpools-About)
-   [Adding a rotation pool](#Rotationpools-Addingarotationpool)

# Adding a rotation pool

To add a new rotation pool you need to edit Nagvis main configuration file. Follow the steps below to configure a basic rotation pool with two maps:

1.  Choose a few maps that you want to use in your rotation pool
2.   Log on to your OP5 Monitor server as root via ssh or directly at the console.
3.  Open up NagVis main configuration file  in your favorite editor: */opt/monitor/op5/nagvis\_ls/etc/nagvis.ini.php*
4.  Go down to the "**Rotation pool definitions**" section and add the lines in the example below:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    ; ----------------------------
    ; Rotation pool definitions
    ; ----------------------------
    [rotation_demo] 
    rotationid="demo" 
    maps="Map One:map1,Map Two:map2" 
    interval=15 
    ```

5.  Save and quit your editor.

6.  Go back to your browser and reload the NagVis default page

The table below describes the options shown above:

Option

Description

[rotation\_NAME]

NAME is the displayed name of this rotation pool on NagVis default page.

rotationid="NAME"

NAME is the ID of this rotation pool, need to be the same as NAME in [rotation\_NAME].

maps="Map One:map1,Map Two:map2"

"Map One" and "Map Two" are labels that are displayed in the rotation pool list on the Nagvis overview page.

"map1" and "map2" are the name of the configuration files for the included maps from */opt/monitor/op5/nagvis\_ls/etc/maps*

interval=15

15 is the rotation time in seconds between the maps.

Maps must be named exactly the same as the corresponding map configuration file, without the extension ".cfg".


