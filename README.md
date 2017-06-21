# OP5 Plugins by Ken D
These checks are 100% unsupported by OP5's support team. You are free to use them as you see fit, however please be aware you take full responsibility for any issues that arrise from using them. If you wish to request assistance from OP5 regarding these unsupported checks and modifications please contact your OP5 representive regarding Professional Services assistance.

Details of files
	Trapper Sync
		very rough start for syncing trapper configuration from masters down to pollers (Not Production Tested source MP)

	check_hue
		Uses the Phillips Hue API to get the metrics you want out of a phillips hue light system

	check_next
		Uses the nest API to pull settings from your nest enviroments.

	check_snmp_percentage
		This check takes 2 OID and reports the Percentage 1 is of the other. It also allows you to monitor if a device like a disk goes from having a value to 0

	sync-local-admins-to-pollers
		This allows you to select a local user group on your master and sync it down to the pollers.
