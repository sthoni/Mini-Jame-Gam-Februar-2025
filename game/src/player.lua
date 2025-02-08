local Shape = require "src//Shape"
local Weapon = require "src.weapon"
local Player = Shape:extend()

function Player:move() -- key, scancode )
	local acc, rot, dt = 0, 0, 1

	if love.keyboard.isDown("up") then -- move right
		acc = 10
	elseif love.keyboard.isDown("down") then -- move left
		acc = -10
	end
	
	--check separately, if lef/right is pressed
	if love.keyboard.isDown("left") then -- move down
		rot = -2
	elseif love.keyboard.isDown("right") then -- move up
		rot = 2
	end
	
	player.rot = rot
	player.acc = acc
	-- if player.rot <= -5 then
	-- 	player.rot = -5
	-- elseif (player.rot > -5) and (player.rot < 5) then
	-- 	player.rot = player.rot + rot * dt
	-- else
	-- 	player.rot = 5
	-- end
 end

function Player:update(dt)
	Player.super.update(self, dt)
	if love.keyboard.isDown("h") then
		self.weapons.addWeapon(self.weapons, "machineGun")
	end
	for key, weapon in pairs(self.weapons.weaponsEquipped) do
		print(weapon.baseDamage)
	end
end

function Player:new(x, y)
	Player.super.new(self, x, y)
	self.test = math.random(1, 1000)
	self.h = 32
	self.w = 32
	self.velocity = 100
	self.tileset = love.graphics.newImage("assets//ships.png")
	self.quad = love.graphics.newQuad(34, 32, self.h, self.w, self.tileset)
	self.weapons = Weapon()
end

function Player:draw()
	local width, height = love.graphics.getDimensions()
	local centerX = width/2
	local centerY = height/2
	love.graphics.push("all")
	love.graphics.translate(self.x + self.h/2, self.y + self.w/2)
	love.graphics.rotate(self.angle)
	love.graphics.draw(self.tileset,self.quad, -self.h/2, -self.w/2)
	-- love.graphics.rectangle("fill", self.x, self.y, self.h, self.w)
	love.graphics.pop()
	-- love.graphics.rotate(-self.angle)
	-- love.graphics.translate(-self.x, -self.y)
end

return Player
