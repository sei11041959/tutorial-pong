local sock = require("lib.sock")

require("lib.log")

info = {host = "127.0.0.1",port = 8080}
connection = 0;
client_data = {}
client_data_thread = {}
client_list = {}



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
        if client_data[1] then
            local data = client_data[1]
            love.graphics.setColor(255,255,255,1)
            love.graphics.rectangle("fill",data.x,data.y,20,100)
        end
        if client_data[2] then
            local data = client_data[2]
            love.graphics.setColor(255,255,255,1)
            love.graphics.rectangle("fill",data.x,data.y,20,100)
        end
    end
end

function event()
    server:on("connect", function(data, client)
        connection = connection + 1
        client:send("msg", "<server> Hello!")
        client:send("No", connection)
        table.insert(client_list,client)
        log:info("client connected")
        log:info(connection)
    end)

    server:on("disconnect", function(data, client)
        log:info("client disconnect")
        for i, v in ipairs(client_list) do
            if v == client then
                table.remove(client_list,i)
                if client_data[i] then
                    client_data[i] = nil
                end
            end
        end
        connection = connection - 1
    end)

    server:on("client_data", function(data, client)
        if data then
            client_data[data.client_No] = data
            if data.client_No == 1 then
                if client_data[2] then client:send("enemy_data",client_data[2]) end
            elseif data.client_No == 2 then
                if client_data[1] then client:send("enemy_data",client_data[1]) end
            end
        end
    end)
end