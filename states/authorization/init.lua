local machine = require('FSM')
local fsm = machine.create({
	initial = 'auth',
	
	events = {
		{ name = 'authmenu', from = 'auth', to = 'menu' },
		{ name = 'exit', from = 'menu', to = 'auth' }
	}
})

return fsm
