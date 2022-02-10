local machine  = require('fsm')

fms = machine.create({
	initial = 'auth',

	events = {
		{ name = 'authmenu', from = 'auth', to = 'menu' },
		{ name = 'exit', from = 'menu', to = 'auth' }
	}
})

fms.onstatechange = function(self, event, from, to) print(event, from, to) end

fms:authmenu()
fms:exit()

fms:todot('test.txt')