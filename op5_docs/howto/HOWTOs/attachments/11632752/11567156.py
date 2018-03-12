#!/usr/bin/env python

# Built on boilerplate form pynag:
# https://github.com/pynag/pynag/wiki/Writing-Plugins-with-pynag.Plugins.PluginHelper

# Example usage:
# python pynag2.py -s WARNING --th metric=some-metrics,ok=0..5,warning=5..10,critical=10..inf

#Modules
from pynag.Plugins import PluginHelper, ok, warning, critical, unknown
helper = PluginHelper()

# Arguments
helper.parser.add_option("-s", help="Exit State", dest="state", default='OK')

helper.parse_arguments()
if helper.options.state == "OK":
	helper.status(ok)
elif helper.options.state == "WARNING":
	helper.status(warning)
elif helper.options.state == "CRITICAL":
	helper.status(critical)
elif helper.options.state == "UNKNOWN":
	helper.status(unknown)
else:
	print "No state specified, calculating from input metrics."

helper.add_metric(label='some-metrics',value=5)
helper.add_summary("Some status message.")

helper.check_all_metrics()
helper.exit()