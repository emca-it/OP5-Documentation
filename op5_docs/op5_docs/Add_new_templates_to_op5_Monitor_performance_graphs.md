# Add new templates to op5 Monitor performance graphs

## **Introduction**

op5 Monitor includes support for graphing what’s known as “performance data” returned by check plugins that support this feature. Performance data can be anything that gives a more detailed picture of a particular check’s performance characteristics than the OK/WARNING/CRITICAL levels that Monitor reacts to.

For example, check\_ping returns performance data for packet loss and round trip times. This data is stored by op5 Monitor and used to create graphs for different time periods, such as the last 24 hours and past week. This feature can be very helpful in identifying trends or potential problems in a network.

The purpose of this article is to describe how one can add support for new plugins to op5 Monitor’s graph system, and create what is known as “templates” for the graph system.

## **Prerequisites**

To be able to complete this how-to you will need the following:

-   op5 Monitor installed correctly
-   a host to which you can add a service for testing purposes
-   a check, returning performance data that you want to graph (or use the dummy check)

## **How to see if a check returns performance data**

Execute the check and observe its output, from the command line or “Test this service”

This is the output of check\_ping:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
OK - 127.0.0.1: rta 0.007ms, lost 0%|rta=0.007ms;200.000;500.000;0; pl=0%;40;80;;
```

The data in the output \_after\_ the | (pipe) sign is performance data. If your check output contains something like this, it supports performance data and can be graphed.

## **Adding a dummy service to graph**

For demonstration purposes we will use a dummy check that we will create a graph template for. If you have a check in your system already that returns performance data which you want to create a graph for, feel free to skip this section and replace references to check\_dummy\_howto with your own check name.

Create the file /opt/plugins/check\_dummy\_howto and fill it with the below script.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
#!/bin/bash
RANGE=100
DS1=$RANDOM
let "DS1 %= $RANGE"
RANGE=500
DS2=$RANDOM
let "DS2 %= $RANGE"
/opt/plugins/check_dummy 0 "Perfdata graph dummy check|pct=$DS1%;80;95;0; val=$DS2;350;450;0;"
```

Make this script executable by everyone:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
chmod a+x /opt/plugins/check_dummy_howto
```

Try executing the file, you should see output similar to this (all on one line):

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# /opt/plugins/check_dummy_howto OK: Perfdata graph dummy check|pct=11%;80;95;;val=139;350;450;;
```

Now, open up op5 Monitor’s web interface and go to Configure. Add a new check command with the below settings:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
command_name: check_dummy_howto command_line: $USER1$/check_dummy_howto
```

And save the command. Then add a service to a non-critical host using this check\_command. Remember to verify that the check works as expected by using “Test this service”

If everything checks out, save the configuration. op5 Monitor will now start to execute check\_dummy\_howto with its regular check interval, and save the performance data returned by the script. Now is a good time for a coffee break, to let Monitor gather some data to work with.

**
**

**Creating a custom graph template**

If you go to the dummy service we created above in the web interface, and click the statistics icon to show the graphs of performance data, you will see that Monitor is already graphing the results of the plugin. However, in the low right corner of the graphs it will say “Default Template”, because Monitor does not know what kind of values it is plotting which means that the graphs are very generic.

Let’s build a custom template to display this performance data in a more effective and prettier way. Our new template should:

-   combine the two series of data our plugin generates into a single graph
-   use separate colors to differentiate between the data series
-   have custom titles and legends describing the graphed data.

It doesn’t sound like much, but it makes a lot of difference when you see the graph!

op5 Monitor includes many graph templates that support different plugins included in the distribution. You can find the included template files in this directory:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
/opt/monitor/op5/pnp/templates.dist
```

Templates are PHP files that are named after the check plugin they work with. So for example a check\_command called check\_ping has a template with the name check\_ping.php.

When creating a custom template file you place it in this directory:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
/opt/monitor/op5/pnp/templates
```

Let’s go ahead and create an empty .php file named after the plugin we want to make a custom graph for. If you are using the dummy plugin we created earlier, call it:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
/opt/monitor/op5/pnp/templates/check_dummy_howto.php
```

 

Remember to start encapsulating the template code between:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
<?php

(code)

?>
```

 

The only thing a graph template file should do is to set two variables. It must not produce any output, and it must be valid PHP (which is not that hard to do!).

The two variables are arrays named \$opt and \$def. It is optional to set a value in \$opt, but \$def always needs to be defined. Each graph has exactly one value in each of these arrays. So, if you wanted to create three graphs, you would have three values in \$opt and three values in \$def. The values are simply long text strings that contain arguments and data to the graph engine.

Our dummy plugin returns two performance data values, two series of data, and a default template would create one graph per series. But we want to show both series of data in one graph, so we will only have one value in each of \$opt and \$def.

Let’s start by adding our first data series:

``` {.php data-syntaxhighlighter-params="brush: php; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: php; gutter: false; theme: Confluence"}
$def[1] = ""; 
$def[1] .= "DEF:ds1=$rrdfile:$DS[1]:AVERAGE ";
$def[1] .= 'LINE:ds1#00FF00:"Percentage points " ';
```

Let’s go over what these lines do: the first line only initialize \$def[1] with an empty string, so that we don’t have to remember to change the assignment operator in later lines.

The second line DEFines a data series (or data source), calls it ds1 and gives it the value of the first data series returned by our plugin. AVERAGE only means that the graph engine uses the AVERAGE of the values returned, if they are several. The dummy plugin we are using only returns one value per run and series, so this has no effect for us.

The third line tells the graph engine how to draw the data we just defined. We tell it to draw a line in the color \#00FF00 (which is the hexadecimal RGB value for green) and give the line a legend with the name “Percentage points”.

That was pretty simple, right? You can go ahead and take a look at the statistics screen of your service in Monitor now. If everything is working as it should, you should now see a clean graph with a single green line showing the first of the data series returned by your plugin.

We can add the second data series to the graph by simply adding these two lines:

``` {.php data-syntaxhighlighter-params="brush: php; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: php; gutter: false; theme: Confluence"}
$def[1] .= "DEF:ds2=$rrdfile:$DS[2]:AVERAGE ";
$def[1] .= 'LINE:ds2#0000FF:"Pirate population" ';
```

Set up a good title for your graph and y-axis with this (all on one line):

``` {.php data-syntaxhighlighter-params="brush: php; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: php; gutter: false; theme: Confluence"}
$opt[1] = '--title "Pirate population / global temperature change" --vertical-label "pirates / degrees"';
```

Try changing the second data series to draw an AREA instead of a LINE:

``` {.php data-syntaxhighlighter-params="brush: php; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: php; gutter: false; theme: Confluence"}
$def[1] .= 'AREA:ds2#0000FF:"Pirate population" ';
```

Have a look at your graphs now. Notice that the first line has disappeared behind the blue area. This is because graph objects are drawn in the order they are specified in the template file, so the first line is drawn and then the blue area is drawn over it.

If you change places between the first and second statements, you can see that the green line is now drawn over the blue area.

If you want, you can change the first line to be an area as well:

``` {.php data-syntaxhighlighter-params="brush: php; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: php; gutter: false; theme: Confluence"}
$def[1] .= 'AREA:ds1#00FF00:"Global temperature increase in %":STACK ';
```

That last part, “:STACK”, means that the second area will be stacked on top of the first. This is a useful way to show values that add up to a total, such as bandwidth usage per customer, or memory usage per application.

## **Conclusion**

This how-to only scratches the surface of what is possible to do with graph templates in op5 Monitor. If you want to learn more, you can find documentation for the components here:

RRDTool: <http://oss.oetiker.ch/rrdtool/doc/index.en.html>

 

 

