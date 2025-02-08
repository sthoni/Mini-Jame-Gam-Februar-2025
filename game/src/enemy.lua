local Shape = require "src//Shape"
local Enemy = Shape:extend()

function Enemy:move() -- key, scancode )
	local diffX = player.x - self.x
	local diffY = player.y - self.y

	local diffVec = vec2(diffX, diffY)
	self.angle = diffVec:angle() + math.pi / 2

	self.acc = 1
	self.rot = 0
end

function Enemy:new(x, y)
	Enemy.super:new(x, y)
	self.test = math.random(1, 1000)
	self.h = 32
	self.w = 16
	self.velocity = 25
	self.tileset = love.graphics.newImage("assets//ships.png")
	self.quad = love.graphics.newQuad(72, 173, self.h, self.w, self.tileset)
	self.maxspeed = 50
end

function Enemy:draw()
	love.graphics.push("all")
	love.graphics.translate(self.x + self.h / 2, self.y + self.w / 2)
	love.graphics.rotate(self.angle)
	love.graphics.draw(self.tileset, self.quad, -self.h / 2, -self.w / 2)
	love.graphics.pop()
end

return Enemy
