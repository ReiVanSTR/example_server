local StateManager = {}
local states = require("states")
local helper = require("LuaHelper")
local profile = states.profile
local _user = require("user")


profile.authMutation = function(user) profile.user = _user:new(user) end


StateManager.profile = profile
return StateManager