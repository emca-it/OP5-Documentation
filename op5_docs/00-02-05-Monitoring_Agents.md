# Monitoring Agents

# About

op5 Monitor can do a lot on its own. But to get the most out of OP5 Monitor you should use our agents.
The following agents are available from the download section in the support section at http://www.op5.com/get-op5-monitor/download/\#Agents-tab.

- OP5 NSClient++
  - NRPE
  - MRTGEXT
  - Windows syslog Agent
  - Nagstamon

op5 NSClient++

This is the agent used for monitoring Microsoft Windows operating systems.
 You can use it to monitor things like

- CPU, memory and disk usage
  - services, windows events and files

You can also use the built-in NRPE support to create your own commands for OP5 NSClient++

NRPE

This is the most commonly used agent for Linux and Unix systems. NRPE is used to execute plugins on an remote machine and then send the results back to OP5 Monitor.
You may also send arguments to the NRPE daemon on the remote machine to make it a bit more flexible. This must be turned on before you use the feature.

MRTGEXT

MRTGEXT was originally written as an NLM for Novel Netware to obtain values used with the widely known MRTG, but it can also be used to poll values from OP5 Monitor.

op5 Syslog Agent

op5 Syslog Agent runs as a service under Windows. It formats all types of Windows Event log entries into syslog format and sends them to a syslog host (The OP5 Monitor server or the OP5 LogServer).
The agent can also forward plaintext log-files.

Nagstamon

Nagstamon is a status monitor for the desktop. It can connect to several servers and resides in the systray or as a floating statusbar at the desktop showing a brief summary of critical, warning, unknown, unreachable and down hosts and services and pops up a detailed status overview when moving the mouse pointer over it

 More information about the agents can be found in the [OP5 Monitor Administrator Manual](op5_Monitor_Administrator_Manual).
