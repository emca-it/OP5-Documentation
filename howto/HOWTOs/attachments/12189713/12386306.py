#!/usr/bin/env python

import argparse

parser = argparse.ArgumentParser(
    description="Example third-party check plugin")

parser.add_argument("-H", "--host", help="Target host", required=True)
parser.add_argument("-a", "--argument", help="First argument", required=True)

args = parser.parse_args()

print "OK - Monitoring host %s with argument %s" % (args.host, args.argument)
exit(0)
