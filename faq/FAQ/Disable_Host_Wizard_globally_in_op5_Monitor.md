# Disable Host Wizard globally in OP5 Monitor

## How do I prevent the Host Wizard to show up for users logging in for the first time?

* * * * *

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# mkdir -p /opt/monitor/op5/ninja/modules/wizard/config/custom
# cp -a /opt/monitor/op5/ninja/modules/wizard/config/wizard.php /opt/monitor/op5/ninja/modules/wizard/config/custom
```

## Now edit /opt/monitor/op5/ninja/modules/wizard/config/custom/wizard.php and set:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
$config['display_at_start'] = 0;
```
