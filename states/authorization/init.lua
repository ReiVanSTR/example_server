local machine = require('FSM')
local shell = require('shell')

local meta = loadfile(shell.getWorkingDirectory()..'/authorization/meta.lua')()

local fsm = machine.create({
	initial = 'auth',
	
	events = {
		{ name = 'authmenu', from = 'auth', to = 'menu' },
		{ name = 'exit', from = 'menu', to = 'auth' }
	}
})

return fsm