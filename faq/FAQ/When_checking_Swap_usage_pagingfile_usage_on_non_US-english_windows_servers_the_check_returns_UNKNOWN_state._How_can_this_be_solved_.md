# When checking Swap usage (pagingfile usage) on non US-english windows servers, the check returns UNKNOWN state. How can this be solved?

## Question

* * * * *

When checking Swap usage (pagingfile usage) on non US-english windows servers, the check returns UNKNOWN state. How can this be solved?

## Answer

* * * * *

Add an alternative localized check-command. Use the new check-command in the Swap usage-services that return UNKNOWN state.

This following example is for Swedish Windows-installations:

    command_name: check_nt_pagingfile_swe
    command_line: $USER1$/check_nt -H $HOSTADDRESS$ -p 1248 -v COUNTER -l "\Växlingsfil(_Total)\% i användning","Paging File usage is " -w $ARG1$ -c $ARG2$
