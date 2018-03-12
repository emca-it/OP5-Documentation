# check\_load thresholds

## Question

* * * * *

What is the recommended thresholds for the plugin check\_load in the NRPE agent?

## Answer

* * * * *

It depends on how many cores a system has, but a general recommendation is to never have a load-value over 1.0 per core on a 5 min average.

Example of a calculation to determine what thresholds that should be configured for a Linux or UNIX system:

    y = c * p / 100 

y = threshold value c: number of cores p: wanted load threshold

 

Below are recommendations on how check\_load thresholds should be configured for the most common CPU configurations.

 

The path to the plugin check\_load might differ between different Linux/unix systems.

 

On a single core system the recommended thresholds are:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
command[check_load]=/opt/plugins/check_load -w 0.7,0.6,0.5 -c 0.9,0.8,0.7
```

 

On a dual core (2 cores) system the recommended thresholds are:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
command[check_load]=/opt/plugins/check_load -w 1.4,1.2,1 -c 1.8,1.6,1.4
```

 

On a quad core (4 cores) system the recommended thresholds are:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
command[check_load]=/opt/plugins/check_load -w 3.6,2.8,2.0 -c 4.0,3.2,2.8 
```

 

On a octa core (8 cores) system the recommended thresholds are:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
command[check_load]=/opt/plugins/check_load -w 7.2,5.6,4.0 -c 8.0,6.4,5.6
```

 

On a dodeca core (12 cores) system the recommended thresholds are:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
command[check_load]=/opt/plugins/check_load -w 10.8,8.4,6.0 -c 12,9.6,7.2
```
