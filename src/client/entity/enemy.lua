Enemy = {}

enemy_data = {}

function Enemy:load()
end


function Enemy:updata(dt)
    enemy_data = love.thread.getChannel('enemy_data'):pop()
end


function Enemy:draw()
    if enemy_data then
        love.graphics.setColor(255,255,255,1)
        love.graphics.rectangle("fill",enemy_data.x,enemy_data.y,20,100)
    end
end