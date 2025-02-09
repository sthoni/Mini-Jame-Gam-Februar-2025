local Shape = require "src.shape"
local Enemy = Shape:extend()

function Enemy:move() -- key, scancode )
	local selfPosition = vec2(self.x, self.y)
	local playerPosition = vec2(player.x, player.y)
	local diffVec = playerPosition - selfPosition

	if selfPosition:distance(playerPosition) > 400 then
		selfPosition = enemyManager:getRandomSpawnPosition()
		self.x = selfPosition.x
		self.y = selfPosition.y
	end

	self.angle = diffVec:angle() + math.pi / 2

	self.acc = 1
	self.rot = 0
end

function Enemy:new(x, y, baseHp, maxSpeed, spriteX, spriteY, spriteW, spriteH)
	Enemy.super.new(self, x, y)
	self.w = spriteW
	self.h = spriteH
	self.hp = baseHp
	self.tileset = love.graphics.newImage("assets/ships.png")
	self.quad = love.graphics.newQuad(spriteX, spriteY, self.w, self.h, self.tileset)
	self.maxSpeed = 50
end

function Enemy:draw()
	love.graphics.push("all")
	love.graphics.translate(self.x + self.h / 2, self.y + self.w / 2)
	love.graphics.rotate(self.angle)
	love.graphics.draw(self.tileset, self.quad, -self.h / 2, -self.w / 2)
	love.graphics.pop()
end

return Enemy
