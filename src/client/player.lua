Player = {}

client_data = {}

function Player:load()
    local data = love.thread.getChannel('client_data'):pop()
    self.width = data.width
    self.height = data.height
    self.speed = data.speed
    self.x = data.x
    self.y = data.y
end



function Player:updata(dt)
    self:move(dt)
    self:checkBoundaries()
    love.thread.getChannel('y'):push(self.y)
    players_data = love.thread.getChannel('players_data'):pop()
end


function Player:draw()
    love.graphics.setColor(255,255,255,1)
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    if players_data then
        love.graphics.rectangle("fill",players_data.x,players_data.y,players_data.width,players_data.height)
    end
end

function Player:move(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end
end



function Player:checkBoundaries()
    if self.y < 0 then
        self.y = 0
    elseif self.y  + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
    end
end