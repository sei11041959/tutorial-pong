local sock = require("lib.sock")

require("lib.log")

local info = {host = "127.0.0.1",port = 8080}
local connection = {}
local client_data = {}

function love.load()
    server = sock.newServer(info.host,info.port)
    log:info("waiting for connection. listen "..info.host.." : "..info.port.."")
    event()
end

function love.update(dt)
    server:update()
end

function love.draw()
    if client_data then
        for i, data in ipairs(client_data) do
            love.graphics.setColor(255,255,255,1)
            love.graphics.rectangle("fill",data.x,data.y,data.width,data.height)
        end
    end
end

function event()
    server:on("connect", function(data, client)
        client:send("hello", "<server> Hello!")
        log:info("1 client connected")
        table.insert(connection,client)
    end)

    server:on("disconnect", function(data, client)
        table.remove(connection,client)
        log:info("disconnect 1 client")
    end)

    server:on("client_data", function(data, client)
        --print("y : "..client_data[1].y)
    end)
end