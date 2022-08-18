local player = require("player")
require("menu")

function love.load()
    MainMenu:load()
    Player:load()
end


function love.update(dt)
    --Player:update(dt)
end

function love.draw()
    MainMenu:draw()
    --Player:draw()
end


--[[function checkCollision(a,b)
    if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    else
        return false
    end
end--]]