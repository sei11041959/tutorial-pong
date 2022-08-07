enet = require ("enet")
enet = require "enet"

p1 = {}


enethost = nil
hostevent = nil
clientpeer = nil

function love.load(args)
	host = enet.host_create("localhost:6789")
	p1.x = 50
    p1.y = love.graphics.getHeight() / 2
    p1.width = 20
    p1.height = 100
    p1.speed = 500
end

function love.update(dt)
	serverlisten()	
	clientsend()
end

function love.draw()
	love.graphics.rectangle("fill",p1.x,p1.y,p1.width,p1.height)
end

function serverlisten()
	hostevent = host:service(0)
	if hostevent then
		if hostevent.type == "connect" then 
			print(hostevent.peer, "connected.")
		end
		if hostevent.type == "receive" then
			--print("pos", hostevent.data, hostevent.peer)
			local pd = split(hostevent.data,",")
			playerupdata(pd[1],pd[2],pd[3],pd[4])
		end
	end
end

function playerupdata(x,y,w,h)
	p1.x,p1.y,p1.w,p1.h = x,y,w,h
end

function clientsend()
end

function split(s, delimiter)
	result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end