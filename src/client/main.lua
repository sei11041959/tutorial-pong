require("tcp_client.main")
require("ui.main")

local info;
local connect;


function love.load()
    MainMenu:load()
end


function love.update(dt)
    TCP_client:update(dt)
end

function love.draw()
    MainMenu:draw()
    TCP_client:draw()
end

function checkCollision(a,b)
    if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    else
        return false
    end
end