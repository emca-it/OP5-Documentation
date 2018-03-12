# Why does my password or snmpcommunity with "!" not work

## Question

* * * * *

Why doesn't my configured check work if i have a "**!**" in my password or snmp community?

## Answer

* * * * *

Since "!" is used as a separator in "check\_command\_args" in op5 Monitor, you will need to escape the sign "!" with a "\\" (backslash) to make op5 Monitor interper the character as input and not a separator.

## Example

    check_command_args: username!passw0r\!d!warning!critical
