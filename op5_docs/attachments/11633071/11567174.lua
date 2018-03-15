-- Trap example:
--  .1.3.6.1.4.1.2.6.159.202.1 "MPA.Component.Blade Server.Inserted"
--  .1.3.6.1.4.1.2.6.159.202.2 "Informational"
--  .1.3.6.1.4.1.2.6.159.202.3 "5DC8989A4249385897256B027CDED481"
--  .1.3.6.1.4.1.2.6.159.202.4 "IBM:7870-B3G-99L6386"
--  .1.3.6.1.4.1.2.6.159.202.5 "A blade server was inserted."
--  .1.3.6.1.4.1.2.6.159.202.6 "Alert"
--  .1.3.6.1.4.1.2.6.159.201.4.1.17 "5D C8 98 9A 42 49 38 58 97 25 6B 02 7C DE D4 3F "
--  .1.3.6.1.4.1.2.6.159.201.4.1.16 "5D C8 98 9A 42 49 38 58 97 25 6B 02 7C DE D4 3F "
--  .1.3.6.1.4.1.2.6.159.201.4.1.4 "0E 00 20 01 "
--  .1.3.6.1.4.1.2.6.159.201.4.1.18 1

include "ibm-director-mapping"

local trapType              = trap[[.1.3.6.1.4.1.2.6.159.202.1]]
local trapSeverity          = trap[[.1.3.6.1.4.1.2.6.159.202.2]]
local trapSenderName        = trap[[.1.3.6.1.4.1.2.6.159.202.3]]
local trapManagedObjectName = trap[[.1.3.6.1.4.1.2.6.159.202.4]]
local trapText              = trap[[.1.3.6.1.4.1.2.6.159.202.5]]
local trapCategory          = trap[[.1.3.6.1.4.1.2.6.159.202.6]]

function map(name)
	for i, v in ipairs(mapping) do
		if v[name] then
			return v[name]
		else
			local name2 = string.match(name, "^([%w-]+)%.[%w-]+%.[%w-]+")
			if name2 and v[name2] then
				return v[name2]
			end
		end
	end
	return nil
end

result.service = "IBM-Director"
result.host    = map(trapManagedObjectName) or "IBM-Director"
result.tag     = trapManagedObjectName .. "/" .. trap.oid
result.message = "[" .. trapManagedObjectName .. "] " .. trapText

log(trapManagedObjectName .. " mapped to " .. result.host)

if trapCategory == "Resolution" then
	result.state = STATE.OK
else
	if trapSeverity == "Informational" then
		result.state = STATE.OK
	elseif trapSeverity == "Minor" then
		result.state = STATE.OK
	elseif trapSeverity == "Warning" then
		result.state = STATE.WARNING
	elseif trapSeverity == "Alert" then
		result.state = STATE.CRITICAL
	elseif trapSeverity == "Critical" then
		result.state = STATE.CRITICAL
	elseif trapSeverity == "Fatal" then
		result.state = STATE.CRITICAL
	end
end

