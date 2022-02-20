local shell = require('shell')
local folder = '/data' --Current folder name with path intention '/' 

shell.setWorkingDirectory(shell.getWorkingDirectory()..folder)

--
local data = {
	misc = require('misc'),
	config = require('config')
}
shell.setWorkingDirectory('//home')

return data