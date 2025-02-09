local Enemy = require "src.enemy"

local function EnemyManager()
	local enemiesData = {
		normal = {
			baseHp = 10,
			maxSpeed = 50,
			spriteX = 72,
			spriteY = 172,
			spriteW = 19,
			spriteH = 16
		},
		hard = {
			baseHp = 20,
			maxSpeed = 30,
			spriteX = 34,
			spriteY = 139,
			spriteW = 30,
			spriteH = 16
		},
		extreme = {
			baseHp = 20,
			maxSpeed = 80,
			spriteX = 3,
			spriteY = 173,
			spriteW = 25,
			spriteH = 15
		}
	}

	return {
		enemiesOnMap = {},

		currentMaxEnemies = 50,
		timeToNextLevel = 20,

		spawn = function(self, enemyType)
			-- add Enemy to OnMap
			for key, enemy in pairs(enemiesData) do
				if enemyType == key then
					local enemyNew = Enemy(0, 0, enemy.baseHp, enemy.maxSpeed, enemy.spriteX,
						enemy.spriteY, enemy.spriteW, enemy.spriteH)
					local randomPosition = enemyNew:getRandomPosition()
					enemyNew.x = randomPosition.x
					enemyNew.y = randomPosition.y
					table.insert(self.enemiesOnMap, enemyNew)
				end
			end
		end,
		update = function(self, dt)
			self.timeToNextLevel = self.timeToNextLevel - dt
			if self.timeToNextLevel < 0 then
				self.timeToNextLevel = 10
				self.currentMaxEnemies = self.currentMaxEnemies + 30
			end
			if #self.enemiesOnMap < self.currentMaxEnemies then
				if love.math.random() < 0.05 then
					self:spawn("extreme")
				elseif love.math.random() < 0.2 then
					self:spawn("hard")
				else
					self:spawn("normal")
				end
			end
			for i, enemy in ipairs(self.enemiesOnMap) do
				enemy:update(dt)
				for j = i, #self.enemiesOnMap do --, other_enemy in ipairs(self.enemiesOnMap) do
					other_enemy = self.enemiesOnMap[j]
					local collides, dx, dy = enemy.collider.collisionshape:collidesWith(other_enemy.collider
						.collisionshape)
					if collides then
						other_enemy:collision_move(dx, dy)
					end
				end
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
