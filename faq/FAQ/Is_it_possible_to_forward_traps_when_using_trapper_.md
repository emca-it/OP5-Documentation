# Is it possible to forward traps when using trapper?

## Question

* * * * *

Is it possible to forward traps received by trapper in op5 Monitor? I want to send all incoming traps to a second destination. 

## Answer

* * * * *

Yes, all you need to do is add a config option for this in the config file for collector.

**In /opt/trapper/etc/collector.conf add the following row**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
forward default yourdestinationserver
```

Trapper will still process and handle all traps locally as usual but also forward the traps as well. 

