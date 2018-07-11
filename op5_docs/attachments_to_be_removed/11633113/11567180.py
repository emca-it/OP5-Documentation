#!/usr/bin/env python

import argparse

parser = argparse.ArgumentParser(description="This event handler will increase the memory of a ESX guest when triggered.")

parser.add_argument("--service-state", help='The service state, use $SERVICESTATE$', required=True)
parser.add_argument("--service-state-type", help='The type of the state, use $SERVICESTATETYPE$', required=True)
parser.add_argument("--service-attempt", help='Current attempt number, $SERVICEATTEMPT$', required=True, type=int)
parser.add_argument("--host-name", help='The host name, use $HOSTNAME$', required=True)

args = parser.parse_args()

def increaseEsxGuestMemory(aHost):
	#Do some stuff to increase memory here.
	notifySysAdmin("Nils Nilsson", "We just increased some memory on %s." % (aHost))
	return 0

def notifySysAdmin(aAdmin, aMessage):
	#Notify sysadmin here.
	print "To: %s; %s" % (aAdmin, aMessage)
	return 0

if args.service_attempt == 1 and args.service_state == "CRITICAL" and args.service_state_type == "SOFT":
	increaseEsxGuestMemory(args.host_name)