#!/usr/bin/env python

import argparse

parser = argparse.ArgumentParser(description="Dead Simple Plugin with arguments.")

parser.add_argument(
    "-s",
    help="State type, can be OK, WARNING, CRITICAL or UNKNOWN",
    required=True,
    choices=["OK", "WARNING", "CRITICAL", "UNKNOWN"])

parser.add_argument(
    "-w",
    help="Warning threshold",
    required=True,
    type=int)

parser.add_argument(
    "-c",
    help="Critical threshold",
    required=True,
    type=int)

args = parser.parse_args()

if args.s == "OK":
	print "We are OK. | somegraph=1;%s;%s;;" % (args.w, args.c)
	exit(0)
elif args.s == "WARNING":
	print "We are WARNING. | somegraph=1;%s;%s;;" % (args.w, args.c)
	exit(1)
elif args.s == "CRITICAL":
	print "We are CRITICAL. | somegraph=1;%s;%s;;" % (args.w, args.c)
	exit(2)
elif args.s == "UNKNOWN":
	print "We are UNKNOWN. | somegraph=1;%s;%s;;" % (args.w, args.c)
	exit(3)
else:
	print "Shouldn't be here."
	exit(127)