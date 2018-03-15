# Disable Host wizard globally

## Question

* * * * *

How do I disable the host wizard globally for all users?

## Answer

* * * * *

Simply create a file called **/opt/monitor/op5/ninja/application/config/custom/wizard.php** containing the following:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
<?php defined('SYSPATH') OR die('No direct access allowed.');
$config['display_at_start'] = 0;
 
```

This will not affect users that has already logged in to the system before, but for new users, the Host wizard will not show up.

