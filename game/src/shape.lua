--"Shape" handles movement
local Shape = Object:extend()
local CollisionObject = require "src.collisionObject"

function Shape:new(x, y)
	self.x = x
	self.y = y
	self.pos = { self.x, self.y }
	self.rot = 0
	self.angle = 0
	self.angular_velo = 3.14
	self.speed = { x, y, abs }
	self.speed.x = 0
	self.speed.y = 0
	self.speed.abs = 0
	self.maxspeed = 100
	self.collider = CollisionObject(self.x, self.y)
	-- self.speed.abs = math.sqrt(math.pow(self.speed.x, 2) + math.pow(self.speed.y, 2))
end

function Shape:update(dt)
	self:move()
	self.speed.abs = self.speed.abs + self.acc * 100 * dt
	if self.speed.abs > self.maxspeed then
		self.speed.abs = self.maxspeed
	elseif self.speed.abs < -self.maxspeed then
		self.speed.abs = -self.maxspeed
	end
	if self.rot ~= 0 then
		self.angle = self.angle + 3 * math.abs(self.speed.abs) / self.maxspeed * self.rot * dt
	end
	self.speed.x = self.speed.abs * math.cos(self.angle - math.pi / 2)
	self.speed.y = self.speed.abs * math.sin(self.angle - math.pi / 2)
	self.x = self.x + self.speed.x * dt
	self.y = self.y + self.speed.y * dt
	self.collider:update(dt, self.x + self.h / 2, self.y + self.w / 2)
end

function Shape:move()
end

return Shape
