local sock = require("lib.sock")

require("lib.log")

info = {host = "127.0.0.1",port = 8080}
connection = 0;
client_data = {}
client_list = {}
players = {}



function love.load()
    server = sock.newServer(info.host,info.port)
    log:info("waiting for connection. listen "..info.host.." : "..info.port.."")
    event()
end

function love.update(dt)
    server:update()
    for i, player_data in ipairs(players) do
        server:sendToAll("player_data",player_data)
    end
end

function love.draw()
    if connection ~= 0 then
        for i, player in ipairs(players) do
            local data = player.player_data
            love.graphics.setColor(255,255,255,1)
            love.graphics.rectangle("fill",data.x,data.y,20,100)
        end
    end
end

function event()
    server:on("connect", function( _, client)
        connection = connection + 1
        local player_data = {player_num = connection , player_data = newPlayer(connection)}
        client:send("player_load",player_data)
        table.insert(players,player_data)
        log:info("client connected")
    end)

    server:on("disconnect", function( _, client)
        log:info("client disconnect")
        for i, v in ipairs(client_list) do
            if v == client then
                table.remove(client_list,i)
            end
        end
        connection = connection - 1
    end)

    server:on("y",function (data)
        if data.y and data.player_num then
            players[data.player_num].player_data.y = data.y
        end
    end)
end

function newPlayer(player_num)
    if player_num == 1 then
        return { width = 20,height = 100,speed = 500,x = 50,y = love.graphics.getHeight() / 2}
    elseif player_num == 2 then
        return { width = 20,height = 100,speed = 500,x = love.graphics.getWidth() - 20 - 50,y = love.graphics.getHeight() / 2}
    end
end