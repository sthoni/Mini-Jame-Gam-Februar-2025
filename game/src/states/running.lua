local gamera = require "lib.gamera"

local Level = require "src.level"
local EnemyManager = require "src.enemyManager"
local PickupManager = require "src.pickupManager"
local Projectile = require "src.projectile"

local running = {
	cam = gamera.new(0, 0, 6400, 3600),
	level = Level(),
	enemyManager = EnemyManager(),
	pickupManager = PickupManager(),
	projectile = Projectile(),

	enter = function()
	end,
	exit = function()

	end,
	update = function(self, dt)
		player:update(dt)
		self.enemyManager:update(dt)
		self.projectile:update(dt)
		self.pickupManager:update(dt)
		self.cam:setPosition(player.x, player.y)
		if love.keyboard.isDown("escape") then
			Game:set_state("pausing")
		elseif love.keyboard.isDown("b") then
			Game:set_state("shopping")
		end
	end,
	draw = function(self)
		self.cam:draw(function(l, t, w, h)
			self.level:draw()
			self.projectile:draw()
			self.enemyManager:draw()
			player:draw()
			self.pickupManager:draw()
		end)
	end
}

return running
