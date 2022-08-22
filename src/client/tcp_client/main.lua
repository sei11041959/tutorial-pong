local sock = require("lib.sock")

require("lib.log")
require("player")

local info = {host = "127.0.0.1",port = 8080}
local client;
local client_data;
local load_start;

TCP_client = {}

function TCP_client:load()
end

function TCP_client:update(dt)
    if load_start then
        Player:updata(dt)
    end
    if client then
        client:update()
        updata()
    end
end

function TCP_client:draw()
    if load_start then
        Player:draw()
    end
end

function client_connect()
    client = sock.newClient(info.host,info.port);
    log:info("try server connection ( "..info.host.." : "..info.port.." )")
    client:connect()

    event()
end

function updata()
    client_data = love.thread.getChannel('client_data'):pop()
    if client_data ~= nil then
        client:send("client_data",client_data)
    end
end

function event()
    client:on("connect", function(data)
        log:info("Client connected to the server.")
    end)

    client:on("No",function (data)
        love.thread.getChannel('client_No'):push(data)
        Player:load()
        load_start = data
    end)

    client:on("disconnect", function(data)
        log:info("Client disconnected from the server.")
    end)

    client:on("hello", function(data)
        log:info(data)
    end)
end