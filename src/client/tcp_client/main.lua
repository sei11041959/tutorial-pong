local sock = require("lib.sock")
local log = require("lib.log")

TCP_client = {}

function TCP_client:load()
end

function TCP_client:update(dt)
    client:updata()
end

function TCP_client:draw()
end

function client()
    client = sock.newClient("localhost", 8080)


end
