--"Shape" handles movement
local Shape = Object:extend()
MAXSPD = 400

function Shape:new(x, y)
    self.x = x
    self.y = y
	self.pos = {self.x, self.y}
	self.rot = 0
	self.angle = 0
	self.angular_velo = 3.14
    self.speed = {x,y,abs}
	self.speed.x = 0
	self.speed.y = 0
	self.speed.abs = 0
	-- self.speed.abs = math.sqrt(math.pow(self.speed.x, 2) + math.pow(self.speed.y, 2))
end

function Shape:update(dt)
	self.move()
	player.speed.abs = player.speed.abs + player.acc * 100 * dt
	if player.speed.abs > MAXSPD then
		player.speed.abs = MAXSPD
	elseif player.speed.abs < -MAXSPD then
		player.speed.abs = -MAXSPD
	end
	self.angle = self.angle + 3 * math.abs(player.speed.abs)/MAXSPD * self.rot * dt
	self.speed.x = self.speed.abs * math.cos(self.angle - math.pi/2)
	self.speed.y = self.speed.abs * math.sin(self.angle - math.pi/2)
    self.x = self.x + self.speed.x * dt
	self.y = self.y + self.speed.y * dt
end

return Shape
