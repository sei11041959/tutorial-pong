local socket = require("socket")

require("player")
require("lib.log")

TCP_client = {}

function TCP_client:load()
    Player:load()
end

function TCP_client:update(dt)
    Player:updata(dt)
end

function TCP_client:draw()
    Player:draw()
end