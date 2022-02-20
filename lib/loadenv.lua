--v.1.0.0
-- example: local loadenv = require('loadenv').load(env_file_name or nil) 
local LuaHelper = require('LuaHelper')
local trim  = require('text').trim
local loadenv = {}

function _split(str, symbol)
    local parts = {}
    for part in string.gmatch(str, "([^"..symbol.."]+)") do
       if part ~= "" then
            table.insert(parts, trim(part))
        end
    end
    return parts
end

function _loadfile(filename)
	local filename = filename or '.env'
	local response = {}
	file = io.open(filename, 'r')
	for line in file:lines() do
		local var = _split(line, '=')
		if #var > 1 then
			if #var < 2 then
				print("Variable "..itemPart[1].." has a bad format!")
			else
				table.insert(response, var)
			end
		end
	end
	file:close()
	return response
end

function loadenv.load(env_file_name)
	local variables = _loadfile(env_file_name)
	for _, varset in pairs(variables) do
		os.setenv(varset[1], varset[2])
	end
end

return loadenv