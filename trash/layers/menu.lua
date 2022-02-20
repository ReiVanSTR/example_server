local Menu = {}
local shell = require("shell")
local forms = require("forms")
local computer = require("computer")
local event = require("event")
require("package").loaded["game"] = nil 
local game = require("game")

function Menu:init(user)
	obj = {}
	obj.user = user
	obj.isAuth = true
	obj.isExit = false
	obj.frame = forms.addForm()
	obj.frame.border = 0
	obj.frame.color = 0x000000
	obj.frame.fontColor = 0xffffff
	-- obj.roulette = game.init()
	obj.rouletteFrame = forms.addForm()
	obj.rouletteFrame.left=21
	obj.rouletteFrame.top=4
	obj.rouletteFrame.W=40
	obj.rouletteFrame.H=17
	obj.rouletteFrame.border = 1
	obj.rouletteFrame.color = 0x000000
	obj.rouletteFrame.fontColor = 0x00a3d3
	obj.rouletteFrame.visible = true
	obj.isExit = false
	obj.tickets = 69
	obj.autoExitCounter = 31

	function obj:redraw()
		objects = {}

		local xui = {w=, f=, ...}
		self.frame:addButton(table.unpack(xui))
		--Deposit button
		objects["depositButton"] = self.frame:addButton(3,22,"Пополнить (23)", 
			function(self)
				return true
			end)
		objects["depositButton"].H = 3
		objects["depositButton"].W = 17
		objects["depositButton"].fontColor = 0x00a3d3
		objects["depositButton"].color = 0x000000
		objects["depositButton"].autoSize = false
		objects["depositButton"].centered = truedepositButton
		objects["depositButton"].border = 1

		--Start game button
		objects["startGameButton"] = self.frame:addButton(23,22,"◥◤◢◤◢◣◥◣◥◤ НАЧАТЬ ИГРУ ◥◤◢◤◢◣◥◣◥◤", 
			function(self)
				forms.run(self.rouletteFrame)
				os.sleep(3)
				forms.run(self.frame)
			end)
		objects["startGameButton"].H=3
		objects["startGameButton"].W=36
		objects["startGameButton"].fontColor = 0x00a3d3
		objects["startGameButton"].color = 0x000000
		objects["startGameButton"].autoSize = false
		objects["startGameButton"].centered = true
		objects["startGameButton"].border = 1

		function exit()
			print('exit')
			computer.removeUser(obj.user.nick)
			obj.user:saveLog()
			obj.isAuth = false
			obj.user = nil
			obj.isExit = true
			objects["Timer"]:stop()
			forms.stop(obj.frame)
			event.push("touch")
		end
		--Exit button
		objects["exitButton"] = self.frame:addButton(62,22,"Покинуть", exit)
		objects["exitButton"].H=3
		objects["exitButton"].W=17
		objects["exitButton"].fontColor = 0x00a3d3
		objects["exitButton"].color = 0x000000
		objects["exitButton"].autoSize = false
		objects["exitButton"].centered = true
		objects["exitButton"].border = 1

		--Author label
		objects["authorLabel"] = self.frame:addLabel(1,1,"\nАвтор: ReiVanSTR")
		objects["authorLabel"].W = 20
		objects["authorLabel"].H = 3
		objects["authorLabel"].fontColor = 0x00a3d3
		objects["authorLabel"].color = 0xffffff
		objects["authorLabel"].autoSize = false
		objects["authorLabel"].centered = true

		--Wellcome label
		objects["wellcomeLabel"] = self.frame:addLabel(21,1,"\nДобро пожаловать, "..self.user.nick.."!".." ("..tostring(self.autoExitCounter)..")")
		objects["wellcomeLabel"].W = 40
		objects["wellcomeLabel"].H = 3
		objects["wellcomeLabel"].color = 0x00a658
		objects["wellcomeLabel"].autoSize = false
		objects["wellcomeLabel"].centered = true


		--Balance label
		objects["balanceLabel"] = self.frame:addLabel(61,1,"\nБаланс: "..tostring(self.tickets).." билетов")
		objects["balanceLabel"].W = 20
		objects["balanceLabel"].H = 3
		objects["balanceLabel"].fontColor = 0x00a3d3
		objects["balanceLabel"].color = 0xffffff
		objects["balanceLabel"].autoSize = false
		objects["balanceLabel"].centered = true

		--Game Frame 
		objects["stopLineLeft"] = self.rouletteFrame:addLabel(2,9,"╰──────╮")
		objects["stopLineRight"] = self.rouletteFrame:addLabel(32,9,"╭──────╯")
		objects["stopLineRight"] = self.rouletteFrame:addLabel(14,9,"Game launched")
		-- forms.run(self.rouletteFrame)

		--Tickets border frame
		objects["ticketsFrame"] = self.frame:addFrame(1,4,1)
		objects["ticketsFrame"].W = 20
		objects["ticketsFrame"].H = 17
		objects["ticketsFrame"].fontColor = 0x00a3d3

		--Roulette border frame
		objects["rouletteFrame"] = self.frame:addFrame(21,4,1)
		objects["rouletteFrame"].W = 40
		objects["rouletteFrame"].H = 17
		objects["rouletteFrame"].fontColor = 0x00a3d3

		--Menu border frame
		objects["menuFrame"] = self.frame:addFrame(61,4,1)
		objects["menuFrame"].W = 20
		objects["menuFrame"].H = 17
		objects["menuFrame"].fontColor = 0x00a3d3

		--Tickets label
		objects["ticketsLabel"] = self.frame:addLabel(2,5,"Стоимость билетов:")
		objects["ticketsLabel"].fontColor = 0xffffff

		--Tickets costs list
		objects["ticketCostsList"] = self.frame:addList(3,7)
		objects["ticketCostsList"].W=17
		objects["ticketCostsList"].H=5
		objects["ticketCostsList"].border = 0
		objects["ticketCostsList"]:insert("Эмеральды(1) x 1", 0)
		objects["ticketCostsList"]:insert("ЖБ (77) х 11", 0)
		objects["ticketCostsList"]:insert("МБ (10) x 1", 0)
		objects["ticketCostsList"]:insert("ОБ (120) х 10", 0)
		objects["ticketCostsList"].fontColor = 0x00a3d3
		objects["ticketCostsList"].selColor = 0x000000
		objects["ticketCostsList"].sfColor = 0x00a3d3

		--Helpmenu mywinsButton

		objects["helpMenuMyWonsButton"] = self.frame:addButton(63,6,"Мои выигрыши")
		objects["helpMenuMyWonsButton"].W = 16
		objects["helpMenuMyWonsButton"].H = 3
		objects["helpMenuMyWonsButton"].fontColor = 0x00a3d3
		objects["helpMenuMyWonsButton"].color = 0x000000
		objects["helpMenuMyWonsButton"].autoSize = false
		objects["helpMenuMyWonsButton"].centered = true
		objects["helpMenuMyWonsButton"].border = 1

		--Helpmenu howToPlayButton
		objects["helpMenuHowToPlayButton"] = self.frame:addButton(63,11,"Как играть?")
		objects["helpMenuHowToPlayButton"].W = 16
		objects["helpMenuHowToPlayButton"].H = 3
		objects["helpMenuHowToPlayButton"].fontColor = 0x00a3d3
		objects["helpMenuHowToPlayButton"].color = 0x000000
		objects["helpMenuHowToPlayButton"].autoSize = false
		objects["helpMenuHowToPlayButton"].centered = true
		objects["helpMenuHowToPlayButton"].border = 1

		--Helpmenu helpButton
		objects["helpMenuHelpPage"] = self.frame:addButton(63,16,"Тех. поддержка")
		objects["helpMenuHelpPage"].W = 16
		objects["helpMenuHelpPage"].H = 3
		objects["helpMenuHelpPage"].fontColor = 0x00a3d3
		objects["helpMenuHelpPage"].color = 0x000000
		objects["helpMenuHelpPage"].autoSize = false
		objects["helpMenuHelpPage"].centered = true
		objects["helpMenuHelpPage"].border = 1

		objects["Timer"] = self.frame:addTimer(1, 
			function(self)
				obj.autoExitCounter = obj.autoExitCounter - 1
				objects["wellcomeLabel"].caption = "\nДобро пожаловать, "..obj.user.nick.."!".." ("..tostring(obj.autoExitCounter)..")"
				objects["wellcomeLabel"]:redraw()
				if obj.autoExitCounter == 0 and obj.isAuth then exit() end
			end)

		objects["Event"] = self.frame:addEvent("touch", function() self.autoExitCounter = 31 end)
	end

	function obj:run()
		forms.run(self.frame)
	end

	function obj:stop()
		forms.stop(self.frame)
		objects["Timer"]:stop()
	end

	setmetatable(obj, self)
	self.__index = self;
	return obj
end

return Menu