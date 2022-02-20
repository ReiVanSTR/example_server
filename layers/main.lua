require("package").loaded["user"] = nil
require("package").loaded["auth"] = nil
require("package").loaded["menu"] = nil
local user = require("user")
local auth = require("auth")
local forms = require("forms")
local menu = require("menu")
local computer = require("computer")
local event = require("event")
main = {isAuth = false}

local init = {}

for _,user in pairs({computer.users()}) do computer.removeUser(user) end

init["auth"] = auth:init()
-- init["menu"] = menu:init(init["auth"].user)
init["auth"]:redraw()
init["auth"]:run()
event.shouldInterrupt = function() init["menu"]:stop()  return true end

-- if init["auth"].isAuth then init["menu"]:redraw() init["menu"]:run() while not init["menu"].isExit end

while init["auth"].isAuth do
	if not main.isAuth then 
		init["menu"] = menu:init(init["auth"].user) 
		init["menu"]:redraw() 
		init["menu"]:run() 
		main.isAuth = true
	end
	if init["menu"].isExit then init["auth"].isAuth = false init["auth"]:redraw() init["auth"]:run() main.isAuth = false end
end

-- while init["menu"].isExit do
-- 	init["auth"].isAuth = false
-- 	init["auth"]:redraw() 
-- 	init["auth"]:run()
-- end