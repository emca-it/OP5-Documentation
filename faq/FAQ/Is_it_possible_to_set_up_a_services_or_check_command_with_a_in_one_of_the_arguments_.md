# Is it possible to set up a services or check\_command with a \$ in one of the arguments?

## Question

* * * * *

Is it possible to set up a services or check\_command with a dollar sign (\$) in one of the arguments?

## Answer

* * * * *

Yes, but some careful configuration is needed, in several steps:

- The arguments containing the \$ character must be escaped with yet another \$ character, so it looks like: \$\$
- The arguments in the check command lines must be properly quoted using single quotes.

Begin by looking at (editing) the check command used in this check. Look for the \$ARG*n*\$ [macro](https://kb.op5.com/display/DOC/Macros) corresponding to the argument in the service's check\_command\_args setting. The check command can be set up in three different ways, as outlined by the examples below.

- `$USER1$/check_plugin_example -H $HOSTADDRESS$ -u '$ARG1$' -d '$ARG2$'`
  - \$ARG1\$ and \$ARG2\$ are single quoted.
  - The arguments defined in the service's check\_command\_args setting should be set without quoting, such as:
        `username!mysql$$instance`
- `$USER1$/check_plugin_example -H $HOSTADDRESS$ -u $ARG1$ -d $ARG2$`
  - \$ARG1\$ and \$ARG2\$ are not quoted at all.
  - Add single quotes surrounding your \$ARG*n*\$ as seen in the first example.
  - Set up the service's check\_command\_args setting as described in the first example.
- `$USER1$/check_plugin_example -H $HOSTADDRESS$ -u "$ARG1$" -d "$ARG2$"`
  - \$ARG1\$ and \$ARG2\$ are double quoted.
  - Change from double quotes to single quotes surrounding your \$ARG*n*\$.
  - Set up the service's check\_command\_args setting as described in the first example.

**Why \$\$ and single quotes, then?**

When naemon generates the command line for a check, the first operation is to expand all [macros](https://kb.op5.com/display/DOC/Macros). As \$ is treated as a macro character, it must be type twice to end up as a single \$ – otherwise you get no dollar sign at all! This transformation occurs pre-execution of the command.

The command line to execute is then, in most cases, executed via the system's shell (such as /bin/sh). In many command line shells, \$ characters marks the beginning of a variable string. Only within single quotes, shell variables are not expanded.

For an even better understanding of this issue, spawn a shell such as a bash. For instance, a simple way to do this is by logging on to your OP5 Monitor server via SSH. Then run the commands below.
`my_var=world`
`echo Hello "$my_var"`
`echo Hello '$my_var'`

`unset my_var`
`echo Hello "$my_var"`
`echo Hello '$my_var'`

Do you spot the difference?

What if we use the same argument as in the check command?

`echo "mssql$instance"`
`echo 'mssql$instance'`

And what if instance is a defined variable?

`instance=ABCecho "mssql$instance"`
`echo 'mssql$instance'`

As you can see, single quotes is the only safe option in this check command case.
