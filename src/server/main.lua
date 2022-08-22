local sock = require("lib.sock")

require("lib.log")

info = {host = "127.0.0.1",port = 8080}
connection = 0;
client_data = {}
client_info = {}



function love.load()
    server = sock.newServer(info.host,info.port)
    log:info("waiting for connection. listen "..info.host.." : "..info.port.."")
    event()
end

function love.update(dt)
    server:update()
end

function love.draw()
    if connection ~= 0 then
        for i = 1,connection do
            if client_data[i] then
                local data = client_data[i]
                love.graphics.setColor(255,255,255,1)
                love.graphics.rectangle("fill",data.x,data.y,data.width,data.height)
                print("y : "..client_data[i].y)
            end
        end
    end
end

function event()
    server:on("connect", function(data, client)
        connection = connection + 1
        client:send("hello", "<server> Hello!")
        client:send("No", connection)
        log:info("client connected")
        log:info(connection)
    end)

    server:on("disconnect", function(data, client)
        log:info("client disconnect")
        connection = connection - 1
    end)

    server:on("client_data", function(data, client)
        if data then
            client_data[data.client_No] = data
        end
    end)
end