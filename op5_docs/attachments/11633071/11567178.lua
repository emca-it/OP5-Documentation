#!/opt/trapper/bin/lua

require "luasql.mysql"
require "extra"

function query(format, ...)
	return assert(db:execute(string.format(format, ...)), "Database query failed")
end

match = protected {}

function match.list()
	local cur = query([[
		SELECT host.host_name AS hostname, host.alias AS alias,
			IF(service.service_description = "IBM-Director", service.check_command_args, NULL) AS args
		FROM service LEFT JOIN host ON host.id = service.host_name
		WHERE host.host_name IS NOT NULL
	]])
	return function()
		local match = cur:fetch({}, "a")
		if not match then
			cur:close()
		end
		return match
	end
end

env = assert(luasql.mysql(), "Cannot initialize SQL module")
db = assert(env:connect("nacoma", "nacoma", "nacoma"), "Connection to Database failed")

mapping = {{}, {}, {}}
for match in match.list() do
	mapping[1][match.hostname] = match.hostname
	mapping[2][match.alias]    = match.hostname
	if match.args then
		mapping[3][match.args] = match.hostname
	end
end
print("mapping = " .. serialize(mapping))

db:close()
env:close()
