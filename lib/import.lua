-- import v.1.0.0
-- documentation
local function import(library, objects)
	checkArg(1, library, 'string')
	checkArg(2, objects, 'table')
	local state
	local commit = {}

	-- documentation
	if pcall(function() require(library) end) then state = require(library) else return false end

	for _, object in pairs(objects) do
		if state[object] ~= nil then
			commit[object] = state[object]
		end
	end
	return commit
end

return import