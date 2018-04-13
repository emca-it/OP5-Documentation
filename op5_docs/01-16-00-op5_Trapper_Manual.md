# OP5 Trapper Manual

# About

OP5 Monitor can receive standard SNMP traps by adding the SNMP Rule Based Trap Handler to yourOP5 Monitor will give you advanced functionality to process traps.

- Traps stored in local database for intelligent filter and rule handling
- Handling of status changes i.e. a status is change when you or a rule decides so
- Build your own filters and rules
  - Example: Trap A is received and that is OK, but if Trap B is received within x minutes then status is not OK.
- Enables you to save “state” status between many traps
- Traps are handled as passive checks in Monitor Enterprise
- Alarms and events are stored as events and as such also SLA, event and Availability reports

# Preface

Throughout the manual the term \`trap\` from SNMP v1 and \`notification\` from SNMP v2 are used interchangeably except the places where it is stated explicitly.
For the sake of readability of the examples we are using the fake, short SNMP OIDs like ".1.1", ".1.2", ".1.3". Of course, you have to use the real OIDs instead.