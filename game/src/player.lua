local Shape = require "src//Shape"
local Player = Shape:extend()

function Player:move() -- key, scancode )
	local acc, rot, dt = 0, 0, 1

	if love.keyboard.isDown("up") then -- move right
		acc = 10
	elseif love.keyboard.isDown("down") then -- move left
		acc = -10
	end
	
	--check separately, if lef/right is pressed:
	if love.keyboard.isDown("left") then -- move down
		rot = -2
	elseif love.keyboard.isDown("right") then -- move up
		rot = 2
	end
	
	player.rot = rot
	player.acc = acc
 end

function Player:new(x, y)
	Player.super.new(self, x, y)
	Player.collider = HC.circle(100,100,20)
	self.h = 32
	self.w = 32
	self.velocity = 100
	self.tileset = love.graphics.newImage("assets//ships.png")
	self.quad = love.graphics.newQuad(34, 32, self.h, self.w, self.tileset)
end

function Player:draw()
	local width, height = love.graphics.getDimensions()
	local centerX = width/2
	local centerY = height/2
	love.graphics.push("all")
	love.graphics.translate(self.x + self.h/2, self.y + self.w/2)
	love.graphics.rotate(self.angle)
	love.graphics.draw(self.tileset,self.quad, -self.h/2, -self.w/2)
	love.graphics.pop()
end

return Player
