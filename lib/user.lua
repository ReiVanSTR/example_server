local User = {}
local Tools
local component = require("component")
local computer = require("computer")
local fs = require("filesystem")
local shell = require("shell")
local serialization = require("serialization")

function User:new(userName)
    local obj = {}
    obj.nick = userName
    obj.logPath = '/home/logs/'..userName..'.txt'
    obj.logs = {
        loginDate = os.date(), --getTime(2)
        errors = {},
    }

    function obj:saveLog()
        if fs.exists(self.logPath) then shell.execute("rm "..self.logPath) end
        local file = io.open(self.logPath, "a")
        file:write(serialization.serialize(self.logs))
        file:close()
        return true
    end

    function obj:update(logType, data)
        checkArg(1, logType, "string")
        if not self.logs[logType] then self.logs[logType] = {} end
        table.insert(self.logs[logType], data)  
    end

    function obj:auth()
        local response, message = computer.addUser(self.nick)
        if response then 
            return true
        else
            return response, message
        end
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end

function User:tools()
    local obj = {}

    function obj:load(path)
        checkArg(1, path, "string")
        if not fs.exists(path) then return "Path is not exists" end
        local buff = ""
        local response = {}
        for line in io.lines(path) do
            buff = buff..line
        end
        response = serialization.unserialize(buff)
        return response
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end
    
    
    

function _getHostTime(timezone) --Получить текущее реальное время компьютера, хостящего сервер майна
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

function _getTime(timezone) --Получет настоящее время, стоящее на Хост-машине
    local time = {_getHostTime(timezone)}
    local text = string.format("%d-%d  %02d:%02d:%02d",time[1], time[2], time[4], time[5], time[6])
    return text
end

return User