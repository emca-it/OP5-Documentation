# Converting unix timestamps in nagios.log

## Question

* * * * *

How can I convert the unix timestamps found in the nagios and merlin log files into a human readable format?

## Answer

* * * * *

A quick way is to simply run the file through this perl oneliner:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
perl -pe 's/(\d+)/localtime($1)/e' < nagios.log
```

Example: 

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# head -n1 nagios.log | perl -pe 's/(\d+)/localtime($1)/e'
[Fri Aug 1 01:00:00 2014] LOG ROTATION: MONTHLY
```

 

To transform the timestamps into a sortable format instead, and also display the timezone used while converting, the bash function found below (which mostly consists of PHP code) can be used instead.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
e2d()
{
  local php='
    if(isset($argv[1]))
      if(!date_default_timezone_set($argv[1]))
        exit;

    $s = fopen("php://stdin", "r");
    while (!feof($s))
    {
      $l = preg_replace_callback(
        "/^\[([0-9]+)\]/",
        function($m)
        {
          $d = date("Y-m-d H:i:s O", $m[1]);
          return ("[$d]");
        },
        fgets($s)
      );

      echo $l;
    }
    fclose($s);
  '
  
  php <(printf '\n<?php%s?>\n' "$php") "$@"
}
```

All of the text in the block above (i.e. the bash function) can be copied and then pasted into the op5 Monitor server's bash shell (if connected via SSH that is), which will create a command called *e2d* that exists during the current shell session. To always have access to the command, the function can be pasted into *\~/.bashrc* or one of the other bash startup files.

 

A oneliner-formatted version of the function is found below, which is even easier to paste directly into the shell.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
e2d() { php <(printf '\n<?php\nif(isset($argv[1])) if(!date_default_timezone_set($argv[1])) exit; $s=fopen("php://stdin", "r"); while(!feof($s)) { $l=preg_replace_callback("/^\[([0-9]+)\]/", function($m) { $d=date("Y-m-d H:i:s O", $m[1]); return("[$d]"); }, fgets($s)); echo $l; } fclose($s);\n?>\n') "$@"; }
```

 

The command is then used like this:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
e2d < nagios.log
```

 

And some additional examples, which also demonstrates the timezone selection feature (defaults to localtime):

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# head -n1 /opt/monitor/var/nagios.log | e2d
[2014-08-01 00:00:00 +0200] LOG ROTATION: MONTHLY
# head -n1 /opt/monitor/var/nagios.log | e2d GMT
[2014-07-31 22:00:00 +0000] LOG ROTATION: MONTHLY
# head -n1 /opt/monitor/var/nagios.log | e2d Europe/Helsinki
[2014-08-01 01:00:00 +0300] LOG ROTATION: MONTHLY
# head -n1 /opt/monitor/var/nagios.log | e2d America/Chicago
[2014-07-31 17:00:00 -0500] LOG ROTATION: MONTHLY
```

Lists of supported timezones can be found in [the PHP documentation](http://php.net/manual/en/timezones.php).

