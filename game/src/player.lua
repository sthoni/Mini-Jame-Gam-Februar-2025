local Shape = require "src.Shape"
local Weapon = require "src.weapon"
local Player = Shape:extend()

function Player:move() -- key, scancode )
	local acc, rot = 0, 0

	if love.keyboard.isDown("up") then -- move right
		acc = 10
	elseif love.keyboard.isDown("down") then
		acc = -2
	end

	--check separately, if lef/right is pressed
	if love.keyboard.isDown("left") then   -- move down
		rot = -2
	elseif love.keyboard.isDown("right") then -- move up
		rot = 2
	end

	player.rot = rot
	player.acc = acc
 end

function Player:collision_move(dx, dy)
	player.speed.abs = 0
end

function Player:update(dt)
	Player.super.update(self, dt)
	if love.keyboard.isDown("h") then
		self.weapons.addWeapon(self.weapons, "machineGun")
	elseif love.keyboard.isDown("k") then
		self.weapons.addWeapon(self.weapons, "lazerGun")
	end
	self.weapons.update(self.weapons, dt, self.x, self.y, self.angle)
end

function Player:new(x, y)
	Player.super.new(self, x, y)
	-- Player.collisionshape = Collider:circle(PLAYER_SPAWN_POINT_X, PLAYER_SPAWN_POINT_Y, 8)
	self.h = 32
	self.w = 32
	self.tileset = love.graphics.newImage("assets//ships.png")
	self.quad = love.graphics.newQuad(34, 32, self.h, self.w, self.tileset)
	self.weapons = Weapon(self.x, self.y)
end

function Player:draw()
	local width, height = love.graphics.getDimensions()
	local centerX = width / 2
	local centerY = height / 2
	love.graphics.push("all")
	love.graphics.translate(self.x + self.h / 2, self.y + self.w / 2)
	self.collisionshape:moveTo(self.x + self.h/2,self.y + self.w/2)
	love.graphics.rotate(self.angle)
	love.graphics.draw(self.tileset, self.quad, -self.h / 2, -self.w / 2)
	love.graphics.pop()
end

return Player
