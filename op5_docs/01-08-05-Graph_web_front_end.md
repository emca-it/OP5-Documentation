# Graph web front end

## About

This article covers the PNP web front-end configuration.

## Configuration

The behavior of the PNP web front-end can be controlled through the config file */opt/monitor/etc/pnp/config.php*. This is however not recommended as the file will be overwritten during updates of PNP as the paths and options are detected during ./configure.

If adjustments are needed they should be implemented in:

        /opt/monitor/etc/pnp/config_local.php

If this file does not exist the file config.php can be used as a guideline. All variables will be inherited from config.php unless they are specifically overwritten by config\_local.php, i.e. there is no need to copy the entire file in order to change one variable. The file must however always begin with "\<?php". The following example shows what the code should look like in order to set the graph width to 1500:

``` {.php data-syntaxhighlighter-params="brush: php; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: php; gutter: true; theme: Confluence"}
<?php

$conf['graph_width'] = "1500";
```

 To access the PNP web front end through the GUI click on Graphs in the menu.

When adding a new object that produces graphs, a 5 minute delay should be expected until the graph is rendered.
