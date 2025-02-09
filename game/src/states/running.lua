local gamera = require "lib.gamera"

local Level = require "src.level"
local EnemyManager = require "src.enemyManager"
local PickupManager = require "src.pickupManager"
local Projectile = require "src.projectile"

local font = love.graphics.getFont()

local running = {
	cam = gamera.new(0, 0, 6400, 3600),
	level = Level(),
	enemyManager = EnemyManager(),
	pickupManager = PickupManager(),
	projectile = Projectile(),
	highscore = 0,
	text = love.graphics.newText(font, "Time survived: 0"),

	enter = function()
	end,
	exit = function()

	end,
	update = function(self, dt)
		self.highscore = self.highscore + dt
		self.text = love.graphics.newText(font, "Time survived: " .. math.floor(self.highscore) .. " s")
		player:update(dt)
		self.enemyManager:update(dt)
		player:check_enemy_collision(self.enemyManager)
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
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.draw(self.text, 260, 20)
	end
}

return running
