#!/usr/bin/env python

state = "OK"

if state == "OK":
	print "We are OK."
	exit(0)
elif state == "WARNING":
	print "We are WARNING."
	exit(1)
elif state == "CRITICAL":
	print "We are CRITICAL."
	exit(2)
elif state == "UNKNOWN":
	print "We are UNKNOWN."
	exit(3)
else:
	print "Shouldn't be here."
	exit(127)