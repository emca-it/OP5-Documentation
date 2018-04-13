# I would like to monitor a process with a specific argument

## Question

* * * * *

I would like to monitor a process with a specific argument

## Answer

* * * * *

For example if You have a process 'php' with argument:

    "-q /opt/op5sys/bin/config-daemon.php -p /var/run/config-daemon.php.pid -d"

And only want to monitor 'php' processes with just that argument, you can use the plugin "check\_procs" with the option -a, like this:

    ./check_procs -w 10 -c 20 -C php -a "-q /opt/op5sys/bin/config-daemon.php -p /var/run/config-daemon.php.pid -d"

The status output would then be like this:

    PROCS OK: 1 process with command name 'php', args '-q /opt/op5sys/bin/config-daemon.php -p /var/run/config-daemon.php.pid -d'
