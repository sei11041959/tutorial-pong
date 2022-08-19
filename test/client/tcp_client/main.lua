require("player")

TCP_client = {}
local client_data;
local data_receive_thread;
local connection_error;
function tcp_client_start()
    data_receive_thread = love.thread.newThread("tcp_client/data_receive.lua")
    data_receive_thread:start()
    print(data_receive_thread)
    print("data_receive thread start!")
end

function TCP_client:load()
    Player:load()
end

function TCP_client:updata(dt)
    if connection_error == "successfully" then
        Player:update(dt)
        client_data = love.thread.getChannel('client_data'):pop()
        info = love.thread.getChannel('info'):pop()
        print("y :"..client_data.y)
    elseif connection_error == nil then
        connection_error = love.thread.getChannel('connect'):pop()
    end
end

function TCP_client:draw()
    if connection_error == "successfully" then
        Player:draw()
    end
end