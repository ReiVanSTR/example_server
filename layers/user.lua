local User = {}
local component = require("component")
local computer = require("computer")
local shell = require("shell")
local fs = require("filesystem")
function User:new(userName)
    local obj = {}
    obj.nick = userName
    obj.logPath = 'logs/'..userName..".txt"
    obj.logs = {
        loginDate = getTime(2),
        dropItems = {}
    }
    function obj:saveLog()
        local file = io.open(self.logPath, "a")
        file:write('['..self.logs.loginDate..']'..'\n')
        for _,v in pairs(self.logs.dropItems) do file:write('-'.." "..tostring(v)..'\n') end
        file:write('['.."Предметов выпало: "..tostring(#self.logs.dropItems)..' | Время выхода: '..tostring(getTime(2))..']'..'\n\n')
        file:close()
    end

    function obj:auth()
        local response, message = computer.addUser(self.nick)
        if response then 
            return true
        else
            return response, message
        end
    end

    function obj:logout()
        computer.removeUser(self.nick)
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end


function getHostTime(timezone) --Получить текущее реальное время компьютера, хостящего сервер майна
    timezone = timezone or 2
    local file = io.open("/HostTime.tmp", "w")
    file:write("123")
    file:close()
    local timeCorrection = timezone * 3600
    local lastModified = tonumber(string.sub(fs.lastModified("/HostTime.tmp"), 1, -4)) + timeCorrection
    fs.remove("HostTime.tmp")
    local year, month, day, hour, minute, second = os.date("%Y", lastModified), os.date("%m", lastModified), os.date("%d", lastModified), os.date("%H", lastModified), os.date("%M", lastModified), os.date("%S", lastModified)
    return tonumber(day), tonumber(month), tonumber(year), tonumber(hour), tonumber(minute), tonumber(second)
end

function getTime(timezone) --Получет настоящее время, стоящее на Хост-машине
    local time = {getHostTime(timezone)}
    local text = string.format("%d-%d  %02d:%02d:%02d",time[1], time[2], time[4], time[5], time[6])
return text
end

return User
