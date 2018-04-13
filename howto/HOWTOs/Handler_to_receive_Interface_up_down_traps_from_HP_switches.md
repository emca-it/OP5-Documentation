# Handler to receive Interface up/down traps from HP switches

Version

This article was written for version 2.1 of Trapper, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by OP5 Support.

Demo handler for snmp traps from HP switches. Tested with a ProCurve 2520G-8-Port / J9298A.

**handler-hp-linkstatus.lua**  Expand source

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: true; first-line: 1; theme: Confluence; collapse: true" data-theme="Confluence" style="brush: bash; gutter: true; first-line: 1; theme: Confluence; collapse: true"}
-- log
log("caught a trap from host: " .. result.host)

-- dump the trap into logs (to view it in SNMP traps gui) for debugging purposes
-- dump.trap()

-- update passive service check even if there is no state change (useful for keepalive traps)
-- result.notify = NOTIFY.ALWAYS

-- set the rest
result.service = "Interface status"

for k, v in pairs(trap.fields) do
    if string.match(k,'^\.1\.3\.6\.1\.2\.1\.16\.9\.1\.1\.2\.76$') then
        local message = v
        local portname = string.match(message, "port [0-9]+")
        log('Trap severity is CRITICAL, port is ' .. portname)
        result.tag = portname
        result.message = "HP switch port " .. portname .. " is in CRITICAL state"
        result.state = STATE.CRITICAL
    elseif string.match(k,'^\.1\.3\.6\.1\.2\.1\.16\.9\.1\.1\.2\.75$') then
        local message = v
        local portname = string.match(message, "port [0-9]+")
        log('Trap severity is OK, port is ' .. portname)
        result.tag = portname
        result.message = "HP switch port " .. portname .. " is in OK state"
        result.state = STATE.OK
    else
        log('something else happened')
        local message = v
        result.message = message
    end
end
```
