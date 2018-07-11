#!/bin/bash
# chkconfig: 2345 95 50
# description: Xvfb, run X in a virtual X-Window system without graphical environment
# processname: Xvfb
# Thanks to Dan Straw
# http://www.danstraw.com/

XVFB=/usr/bin/Xvfb
XVFBARGS=":99 -nolisten tcp -fbdir /var/run"
PIDFILE=/var/run/xvfb.pid
case "$1" in
    start)
        echo -n "Starting virtual X frame buffer: Xvfb"
        nohup $XVFB $XVFBARGS &
    ;;
    stop)
        echo -n "Stopping virtual X frame buffer: Xvfb"
        pkill -9  Xvfb
        echo "."
    ;;
    restart)
        $0 stop
        $0 start
    ;;
    *)
        echo "Usage: /etc/init.d/xvfb {start|stop|restart}"
        exit 1
esac
exit 0
# - See more at: https://kb.op5.com/display/PLUGINS/Selenium+in+Monitor?src=search#sthash.iIiFxxCD.dpuf
