local socket = require("socket")

client = {}

local host,port = "127.0.0.1",8080
local c = socket.tcp()

function connect_req()
    c:connect(host,port)
    local data,err = c:receive()
    print(data)
    return data
end