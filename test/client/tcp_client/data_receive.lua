local socket = require("socket")

data_receive = {}

local info;

local host,port = "127.0.0.1",8080
local c = socket.tcp()
local info = {
    host = host,
    port = port
}

c:connect(host,port)
love.thread.getChannel('info'):push(info)
print(info.host.." : "..info.port)
while true do
    local data,err = c:receive()
    if data == nil then
        print("data is nil")
        return
    end
    print(data)
    love.thread.getChannel('data'):push(data)
end