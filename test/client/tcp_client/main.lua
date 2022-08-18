require("player")

TCP_client = {}

local data_receive_thread;
game_start = false
function tcp_client_start()
    data_receive_thread = love.thread.newThread("tcp_client/data_receive.lua")
    data_receive_thread:start()
    print(data_receive_thread)
    print("data_receive thread start!")
    game_start = true
end

function TCP_client:load()
    game_start = false
    Player:load()
end

function TCP_client:updata(dt)
    if game_start == true then
        Player:update(dt)
    end
end

function TCP_client:draw()
    if game_start == true then
        Player:draw()
    end
end