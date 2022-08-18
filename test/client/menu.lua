require("connect")

MainMenu = {}

local buttons = {}
local text;


function MainMenu:load()
    table.insert(buttons,newButton("start",function()
        text = connect_req()
        table.remove(buttons,1)
    end))
    table.insert(buttons,newButton("option",function() print("option") end))
    table.insert(buttons,newButton("quit",function() print("quit"); os.exit();end))
end


function MainMenu:updata(dt)
    
end


function MainMenu:draw()
    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()
    --print(mx.." : "..my)

    local button_width = ww * (1/3)
    local button_height = 80
    local margin = 20
    local total_height = (button_height + margin) * #buttons
    local cursor_y = 0
    local font = love.graphics.newFont(32)

    for i,button in ipairs(buttons) do
        button.last = button.now

        local bx = (ww * 0.5) - (button_width * 0.5)
        local by = (wh * 0.5) - (button_height * 0.5) - (total_height * 0.5) + cursor_y

        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)
        local color = {255,255,255,1.0}

        local mx,my = love.mouse.getPosition()
        local hover = mx > bx and mx < bx +button_width and my > by and my < by + button_height

        if hover then
            color = {0.4,0.4,0.5,1.0}
        end

        button.now = love.mouse.isDown(1)
        if hover and button.now and not button.last then
            local clieckfx = love.audio.newSource("assets/click.wav","static")
            love.audio.play(clieckfx)
            button.func()
        end


        love.graphics.setColor(unpack(color))
        love.graphics.rectangle("fill",bx,by,button_width,button_height)
        love.graphics.setColor(0,0,0,1)
        love.graphics.print(button.text,font,(ww * 0.5) - textW * 0.5,by + textH * 0.5)

        cursor_y = cursor_y + (button_height + margin)
    end
    if text ~= nil then
        love.graphics.setColor(255,255,255,1.0)
        love.graphics.print(text,font,0,0)
    end
end

function newButton(text,func)
    return {
        text = text,
        func = func,

        now = false,
        last = false
    }
end