local shell = require('shell')
local folder = '/scenes' --Current folder name with path intention '/' 

shell.setWorkingDirectory(os.getenv('wd')..folder)

--
local scenes = {
	auth = require('auth'),
	menu = require('menu'),
}
shell.setWorkingDirectory(os.getenv('wd'))

return scenes