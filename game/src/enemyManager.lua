local Enemy = require "src.enemy"

local function EnemyManager()
	local enemiesData = {
		normal = {
			baseHp = 10,
			baseVelocity = 40,
			spriteX = 72,
			spriteY = 172,
			spriteW = 19,
			spriteH = 16
		},
		hard = {
			baseHp = 20,
			baseVelocity = 30,
			spriteX = 34,
			spriteY = 139,
			spriteW = 30,
			spriteH = 16
		}
	}

	return {
		enemiesOnMap = {},
		getRandomSpawnPosition = function(self)
			local playerVec = vec2(player.x, player.y)
			local spawnVector = vec2(playerVec.x + love.math.random(-500, 500), playerVec.y + love.math.random(-540, 540))
			if spawnVector:distance(playerVec) < 400 then
				spawnVector = self:getRandomSpawnPosition()
			end
			return spawnVector
		end,
		spawn = function(self, enemyType)
			-- add Enemy to OnMap
			for key, enemy in pairs(enemiesData) do
				if enemyType == key then
					local spawnVector = self:getRandomSpawnPosition()
					local enemyNew = Enemy(spawnVector.x, spawnVector.y, enemy.baseHp, enemy.baseVelocity, enemy.spriteX,
						enemy
						.spriteY, enemy.spriteW, enemy.spriteH)
					table.insert(self.enemiesOnMap, enemyNew)
				end
			end
		end,
		update = function(self, dt)
			if #self.enemiesOnMap < 200 then
				if love.math.random() < 0.8 then
					self:spawn("normal")
				else
					self:spawn("hard")
				end
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
