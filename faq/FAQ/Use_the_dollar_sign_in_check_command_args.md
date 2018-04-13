# Use the dollar sign (\$) in check\_command\_args

## Question

* * * * *

I want to use "\$" as input to a check\_command in check\_command\_args, how can I do this?

## Answer

* * * * *

This can be done by encapsulating the argument containing "\$" in double quotes:  "", and escape the sign \$ with another one so the input is not interpreted as a variable.

See the example below with the plugin "[check\_oracle](https://kb.op5.com/display/PLUGINS/check_oracle)":

Function

Value

check\_command

USER1\$/check\_oracle -l "\$ARG1\$" -u "\$ARG2\$" -p "\$ARG3\$" -o QUERY -a "\$ARG4\$" -w \$ARG5\$ -c \$ARG6\$

check\_command\_args

oracle-01!user!password!select 1 from v\\\$\$database where 'value123' = 'value123'!2!3

**Output**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
_USER1_/check_oracle -l "oracle-01" -u "user" -p "password" -o QUERY -a "select 1 from v\$database where 'value123' = 'value123'" -w 2 -c 3
Result code: OK
OK - Query returned:  1|result=1;2;3
```
