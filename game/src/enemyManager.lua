local Enemy = require "src.enemy"

local function EnemyManager()
	local enemiesData = {
		normal = {
			baseHp = 10,
			baseVelocity = 40,
		},
		hard = {
			baseHp = 20,
			baseVelocity = 30,
		}
	}

	return {
		enemiesOnMap = {},
		spawn = function(self, enemyType)
			-- add Enemy to OnMap
			for key, enemy in pairs(enemiesData) do
				if enemyType == key then
					local startX = player.x + love.math.random(-400, 400)
					local startY = player.y + love.math.random(180, 200) * math.random_sign()
					local enemyNew = Enemy(startX, startY, enemy.baseHp, enemy.baseVelocity)
					table.insert(self.enemiesOnMap, enemyNew)
				end
			end
		end,
		update = function(self, dt)
			if #self.enemiesOnMap < 200 then
				self:spawn("normal")
			end
			for _, enemy in pairs(self.enemiesOnMap) do
				enemy:update(dt)
			end
		end,
		draw = function(self)
			for _, enemy in pairs(self.enemiesOnMap) do
				enemy:draw()
			end
		end,
	}
end

return EnemyManager
