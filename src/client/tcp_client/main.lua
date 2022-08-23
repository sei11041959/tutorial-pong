local sock = require("lib.sock")

require("lib.log")
require("player")

local info = {host = "127.0.0.1",port = 8080}
local client;
local client_data;
local players = {};
local player_num;

TCP_client = {}

function TCP_client:update(dt)
    if client then
        client:update()
    end
    if player_num then
        Player:updata(dt)
        client:send("y",{player_num = player_num,y = love.thread.getChannel('y'):pop()})
    end
end

function TCP_client:draw()
    if player_num and players then
        Player:draw()
    end
end

function client_connect()
    client = sock.newClient(info.host,info.port);
    log:info("try server connection ( "..info.host.." : "..info.port.." )")
    client:connect()

    event()
end

function event()
    client:on("connect", function(data)
        log:info("Client connected to the server.")
    end)

    client:on("disconnect", function(data)
        log:info("client disconnected from the server")
    end)

    client:on("player_load", function(data)
        love.thread.getChannel('client_data'):push(data.player_data)
        Player:load()
        player_num = data.player_num
    end)

    client:on("player_data", function(data)
        if data.player_num == player_num then
            love.thread.getChannel('client_data'):push(data)
            --table.insert(players,data)
        else
            love.thread.getChannel('players_data'):push(data.player_data)
        end
    end)
end