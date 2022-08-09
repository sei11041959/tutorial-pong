enet = require ("enet")
require("player")
local host = enet.host_create()
enethost = nil
hostevent = nil
clientpeer = nil

function love.load()
	enetclient = enet.host_create()
    clientpeer = enetclient:connect("localhost:6789")
	Player:load()
end

function love.update(dt)
	Player:update(dt)
	clientsend()
end

function love.draw()
	Player:draw()
end

function clientreceive()
	hostevent = enethost:service(0)
	
	if hostevent then
		if hostevent.type == "connect" then 
			print(hostevent.peer, "connected.")
		end
		if hostevent.type == "receive" then
			print("message: ", hostevent.data, hostevent.peer)
		end
	end
end

function clientsend()
	enetclient:service(0)
	clientpeer:send(Player.x..","..Player.y..","..Player.width..","..Player.height)
end