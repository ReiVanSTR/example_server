local StateManager = {}
local states = require("states")
local helper = require("LuaHelper")
local profile = states.profile


profile.authMutation = function(user) profile.user = user end
profile.authMutation()


return StateManager