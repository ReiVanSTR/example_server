local authScene = {}
local events = loadfile(os.getenv('wd')..'/scenes/auth/authevents.lua')()
local forms = require('forms')

function authScene.make()
	TComponent = {W=1, H=1, color = 0x606060}
	local scene = forms.addForm(_unpack(TComponent))
end

return authScene