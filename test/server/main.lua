local uv = require("luv")


local server = uv.new_tcp()
local host,port = "127.0.0.1",8080
local connection = 0

clients = {}
clients[1] = {}
clients[2] = {}


function connect_reqest()
    local uv = require("luv")

    local client = uv.new_tcp()
    server:accept(client)
    client:write("<server> hello!\n")

    connection = connection + 1
    local i = uv.tcp_getpeername(client)
    print("connection from "..i.ip..":"..i.port)
    table.insert(clients[1],client)

    client:read_start(function (err,data)
        if data == "closed" then
            connection = connection - 1
            for i, v in ipairs(clients[1]) do
                if client == v then table.remove(clients[1],i);print("disconected") end
            end
        elseif data then
            print(data)
        end
    end)
    uv.run()
end

server:bind(host,port)

server:listen(128, function (err)
    uv.new_thread(connect_reqest())
end)
print("TCP server listening at "..host.." : "..port)

uv.run()