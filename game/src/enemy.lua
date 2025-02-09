local Shape = require "src.shape"
local Enemy = Shape:extend()

function Enemy:move() -- key, scancode )
	local diffX = player.x - self.x
	local diffY = player.y - self.y

	if math.abs(diffX) > 350 then
		self.x = player.x + love.math.random(-400, 400)
	end

	if math.abs(diffY) > 220 then
		self.y = player.y + love.math.random(230, 300) * math.random_sign()
	end

	local diffVec = vec2(diffX, diffY)
	self.angle = diffVec:angle() + math.pi / 2

	self.acc = 1
	self.rot = 0
end

function Enemy:collision_move(dx,dy)
	self.x = self.x + dx
	self.y = self.y + dy
end

function Enemy:new(x, y, baseHp, baseVelocity)
	Enemy.super.new(self, x, y)
	self.h = 32
	self.w = 16
	self.hp = baseHp
	self.velocity = baseVelocity
	self.tileset = love.graphics.newImage("assets//ships.png")
	self.quad = love.graphics.newQuad(71, 173, self.h, self.w, self.tileset)
	self.maxspeed = 50
end

function Enemy:draw()
	love.graphics.push("all")
	love.graphics.translate(self.x + self.h / 2, self.y + self.w / 2)
	love.graphics.rotate(self.angle)
	love.graphics.draw(self.tileset, self.quad, -self.h / 2, -self.w / 2)
	self.collider:draw()
	love.graphics.pop()
end

return Enemy
