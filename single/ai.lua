AI = {}

function AI:load()
    self.width = 20
    self.height = 100
    self.x = love.graphics.getWidth() - self.width - 50
    self.y = love.graphics.getHeight() / 2
    self.yVel = 0
    self.speed = 500

    self.timer = 0
    self.rate = 0.5
end


function AI:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.rate then
        self.timer = 0
        --normal mode
        self:acqioreTarget()
    end
    --VERYSTRONG MODE
    --self:acqioreTarget()
    self:move(dt)
    self:checkBoundaries()
end


function AI:move(dt)
    --normal mode
    self.y = self.y + self.yVel * dt
    --VERYSTRONG MODE
    --self.y = Ball.y + Ball.yVel * dt
end


function AI:checkBoundaries()
    if self.y < 0 then
        self.y = 0
    elseif self.y  + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
    end
end


function AI:acqioreTarget()
    if Ball.y + Ball.height < self.y then
        self.yVel = -self.speed
    elseif Ball.y > self.y + self.height then
        self.yVel = self.speed
    else
        self.yVel = 0
    end
end

function AI:draw()
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
end