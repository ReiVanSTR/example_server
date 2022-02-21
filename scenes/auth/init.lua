local authScene = {}
local events = loadfile(os.getenv('wd')..'/scenes/auth/authevents.lua')()
local forms = require('forms')
local _unpack = require('data').misc.unpack

function authScene.make()
	-- Scene raw componnet 
	TComponent = {W = 1, H = 1, color = 0x606060, fontColor = 0xffffff, border = 1}
	local scene = forms.addForm(_unpack(TComponent))

	-- Auth button raw componnet
	TButton = {W = 5, H = 5, caption = 'Авторизироваться', onClick = function(self, player) local player = 'Ivan' events.onAuth(player) end, color = 0xff0064}
	scene:addButton(_unpack(TButton))

	-- Animation Timer raw componnet
	TTimer = {interval = 1, onTime = function(self) print(1) os.sleep(1) events.onAnimationTime(self.elements, 'Авторизироваться') end}
	scene:addTimer(_unpack(TTimer))

	return scene
end

return authScene