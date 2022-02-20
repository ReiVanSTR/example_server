local forms = require("forms")

Game = {}

function Game:init()
	obj = {}
	obj.form = forms.addForm(1,1)
	obj.form.left=21
	obj.form.top=4
	obj.form.W=40
	obj.form.H=17
	obj.form.border = 1
	obj.form.color = 0x000000
	obj.form.fontColor = 0x00a3d3
	obj.form.visible = true
	obj.droplistPath = "items/items.txt"
	obj.stepCounter = 0

	-- function obj:redraw()
	-- 	if not self.labels then self.labels = {} end
	-- 	local y = 5
	-- 	for k = 1, 7 do
	-- 		self.labels[k] = form:addLabel(25,y,"")
	-- 		y=y+2
	-- 	end
	-- end

	-- function obj:genItemsTable(qty)
	-- 	local function split(str, symb)
	-- 	    local parts = {}
	-- 	    for m in string.gmatch(str, "([^"..symb.."]+)") do
	-- 	 	   if m ~= "" then
	-- 	    		table.insert(parts, m)
	-- 	    	end
	-- 	   	end
	-- 		return parts
	-- 	end

	-- function loadItems(array)
	-- 		local file = io.open(self.droplistPath, "r")
	-- 		for line in file:lines() do
	-- 			chanse = 0
	-- 			part = split(line, " ")
	-- 			if #part > 1 then
	-- 				chanse = tonumber(part[2])
	-- 				itemPart = split(part[1],":")
	-- 				if #itemPart < 2 then 
	-- 					print("Item "..itemPart[1].." has a bad format!")
	-- 				else	
	-- 					if #itemPart > 2 then
	-- 						table.insert(array, {chanse = chanse, step=stepCounter, item={name=itemPart[1]..":"..itemPart[2], damage=tonumber(itemPart[3])}, rare=part[3]})
	-- 					else
	-- 						table.insert(array, {chanse = chanse, step=stepCounter, item={name=itemPart[1]..":"..itemPart[2]}})
	-- 					end
	-- 					stepCounter = stepCounter + chanse
	-- 				end
	-- 			end	
	-- 		end
	-- 		file:close()
	-- 		return array
	-- 	end

	-- function genItem(itemsArray)
	-- 		val = self.stepCounter*math.random()
	-- 		prevItem = items[1].item
	-- 		for k=2,#items do
	-- 			if itemsArray[k].step < val then
	-- 				prevItem = itemsArray[k].item
	-- 			else
	-- 				break
	-- 			end			
	-- 		end	
	-- 		return prevItem
	-- 	end

	-- 	local items = loadItems({})
	-- 	local response = {}
	-- 	for item = 1, qty do
	-- 		table.insert(response, genItem(itemsArray))
	-- 	end
	-- 	return response
	-- end
	-- obj:redraw()
end

return Game