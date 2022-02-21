local authEvents = {}
local profile = require('stateManager').profile

function authEvents.onAuth(user)
	profile.authMutation(user)
end

function authEvents.onAnimationTime(objects, label)
	print('ok')
	os.sleep(1)
	local _object
	for _, object in pairs(objects) do if object.caption == label then _object = object else return false end end

	local _buff = _object.caption
	local _pos = 0
	if pos < 4 then
		_object.caption = "> ".._object.caption.."< "
		_object:redraw()
	else
		_object.caption = buff
		_object:redraw()
		pos = 0
	end

end
	
return authEvents