local shell = require('shell')
local folder = '/states' --Current folder name with path intention '/' 

shell.setWorkingDirectory(shell.getWorkingDirectory()..folder)

--
local states = {
	auth = require('authorization'),
	menu = require('menu')
}
shell.setWorkingDirectory('//home')

return states