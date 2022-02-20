local Searcher = {}
local gpu = require("component").gpu
local isPrimary = require("component").isPrimary
local event = require("event")
local uchar = require("unicode").char
local len = require("unicode").len
local sub = require("unicode").sub
local uchar = require("unicode").char
local term = require("term")
local isControl = require("keyboard").isControl
local padRight = require("text").padRight
local pushSignal = require("computer").pushSignal
local computer = require("computer")
local string = require("string")
local find = require("string").find 
local thread = require("thread")

function Searcher:init(left, top, W, H, bgColor, fgColor) --> Table[func, ...]
	local obj = {}
	obj.searchHistory = {}
	obj.left = left
	obj.top = top
	obj.W = W
	obj.H = H
	obj.backgroundColor = bgColor
	obj.foregroundColor = fgColor
	obj.maxDropMenuLen = 5

	function obj:draw() --> Bool
		local oldbg, oldfg = gpu.getBackground(), gpu.getForeground()
		gpu.setBackground(self.backgroundColor)
		gpu.setForeground(self.foregroundColor)
		gpu.set(self.left-2, self.top+1, ">>")
		gpu.set(self.left+self.W+1, self.top+1, "×")
		gpu.setBackground(oldbg)
		gpu.setForeground(oldfg)
		return true
	end

	function obj:search() --> String
		local running = true
		local scrollX, scrollY = 0,0
		local posX, posY = 1,1
		local left = self.left
		local top = self.top
		local W = self.W
		local H = self.H
		local text={}
		text[posY] = ""
		local onSelect = false

		local function drawLine(y)
			gpu.set(left,top + y,padRight(sub(text[y] or "", scrollX+1, scrollX+W),W))
		end

		local function setCursor(newX) -- new x
			posX = newX or posX
			if #text[posY]<1 then text[1]="" end
			if posX<1 then posX=1 end
			local redraw=false
			if posX<=scrollX then scrollX=posX-1 redraw = true end
  			if posX>scrollX+W then scrollX=posX-W redraw = true end
  			if #text[posY] >= W then sub(text[posY],posX) redraw = true end
  			if redraw then drawLine(1)
			else term.setCursor(left+posX-scrollX-1, top+posY) end
		end

		local function insert(value)
		  if not value or len(value) < 1 then return end
		  text[posY]=sub(text[posY],1,posX-1)..value..sub(text[posY],posX)
		  drawLine(posY)
		  setCursor(posX+len(value))
		end

		local keys = {}
			keys[14] = function() -- BackSpace
				if posX > 1 then
					text[posY] = sub(text[posY],1,posX-2)..sub(text[posY],posX)
				    drawLine(posY)
				    setCursor(posX-1)
				else
					text[posY] = sub(text[posY],posX)
					drawLine(posY)
				    setCursor(posX-1)
				end
			end

			keys[203]=function()    -- Left
			  if posX>1 then setCursor(posX-1)
			  else if posY>1 then posY=posY-1 setCursor(len(text[posY])+1) end
			  end
			end

			keys[205]=function()   -- Right
				if posX<=len(text[posY]) then setCursor(posX+1)
				else if posY<#text then setCursor(1,posY+1) end
				end
			end

			keys[28] =function() running=false end   -- Enter

			keys[15] =function() insert("  ") end   -- Tab

			keys[200] = function() end
			keys[208] = function() end
		
		local function onKeyDown(char, code)
				if keys[code] then keys[code]() end
				if not isControl(char) then 
					insert(uchar(char))
				end
			end

		local function onClipboard(value)
			return
		end

		local function onClick(x,y)
			if x == left+W+1 and y == top+1 then 
				text[posY] = "" 
				drawLine(1)
			end
			if x>=left and x<left+W+2 and y>=top+1 and y<top+H+2 then
				if x-left > #text[posY] then x = #text[posY] + left end
		    	setCursor(x+scrollX-left+1,y+scrollY-top+1)
			else running=false
			end
		end

		local function onSelect(y)

		end

		local function drawDropMenu(tbl)
			local y = top + 2
			for _, row in pairs(tbl) do
				gpu.set(left+1, y, row..string.rep(" ", W-len(row)))
				y = y + 1
				if y >= 5 then y=5 end
			end
			gpu.fill(left+1, y, W, y, " ")
		end

		local function findInHistory(parm)
			local status, response = false, {}
			if #self.searchHistory == 0 then return status end
			if parm == "" then return status end
			for _, row in pairs(self.searchHistory) do
				if find(row, parm) then table.insert(response, row) end
			end
			return not status, response
		end

		--Main Event
		term.setCursorBlink(true)
		drawLine(1)
		setCursor(1)

		local event, address, arg1, arg2, arg3
		while running do
			status, his = findInHistory(text[1])
			if status then
				drawDropMenu(his) 
			else
				gpu.fill(left+1, 2, W, 6, " ")
			end
			event, address, arg1, arg2, arg3 = term.pull()
			if type(address) == "string" and isPrimary(address) then
				term.setCursorBlink(false)
				if event == "key_down" then onKeyDown(arg1, arg2)
				elseif event == "clipboard" then onClipboard(arg1)
				elseif event == "touch" then onClick(arg1, arg2)
			end
		    term.setCursorBlink(true)
		  end
		end
		if event=="touch" then pushSignal( event, address, arg1, arg2, arg3 ) end
		term.setCursorBlink(false)
		term.setCursor(1,1)
		table.insert(self.searchHistory, text[1])
		return text[1]
	end

	function obj:setPosition(left, top, W, H) --> Bool
		self.left = left
		self.top = top
		self.W = W
		self.H = H
		self:draw()
		return true
	end


	obj:draw()
	setmetatable(obj, self)
    self.__index = self;
    return obj
end

gpu.fill(1,1,160,50," ")
s = Searcher:init(50,0,20,2, 0x1a, 0x6a)
thread.create(function() while true do gpu.set(5,5, tostring(computer.freeMemory()/1024)) os.sleep(0.5) end end)
while true do
	print(s:search())
end