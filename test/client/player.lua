Player = {}

client_data = {}

function Player:load()
    self.x = 50
    self.y = love.graphics.getHeight() / 2
    self.width = 20
    self.height = 100
    self.speed = 500
    client_data = {x = self.x,y = self.y,width = self.width,height = self.height,speed = self.speed}
    love.thread.getChannel('client_data'):push(client_data)
end



function Player:update(dt)
    self:move(dt)
    self:checkBoundaries()
    client_data = {x = self.x,y = self.y,width = self.width,height = self.height,speed = self.speed}
    love.thread.getChannel('client_data'):push(client_data)
end


function Player:draw()
    love.graphics.setColor(255,255,255,1)
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
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