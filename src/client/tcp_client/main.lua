local sock = require("lib.sock")

require("lib.log")
require("player")

local info = {host = "127.0.0.1",port = 8080}
local client;
local client_data;

TCP_client = {}

function TCP_client:load()
end

function TCP_client:update(dt)
    if client then
        Player:updata(dt)
        client:update()
        updata()
    end
end

function TCP_client:draw()
    if client then
        Player:draw()
    end
end

function client_connect()
    client = sock.newClient(info.host,info.port);
    log:info("try server connection ( "..info.host.." : "..info.port.." )")
    client:connect()

    event()
    Player:load()
end

function updata()
    client:send("client_data",client_data)
end

function event()
    client:on("connect", function(data)
        log:info("Client connected to the server.")
    end)

    client:on("disconnect", function(data)
        log:info("Client disconnected from the server.")
    end)

    client:on("hello", function(data)
        log:info(data)
    end)

    client:on("client_data", function(msg)
        log:info("The server replied: " .. msg)
    end)
end