local shell = require('shell')
local folder = '/states' --Current folder name with path intention '/' 

shell.setWorkingDirectory(os.getenv('wd')..folder)

--
local states = {
	auth = require('authorization'),
	menu = require('menu'),
	profile = loadfile(os.getenv('wd')..'/states/profile_data.lua')()
}
shell.setWorkingDirectory(os.getenv('wd'))

return states