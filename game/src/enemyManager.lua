local Enemy = require "src.enemy"

local function EnemyManager()
	local enemiesData = {
		normal = {
			baseHp = 10,
			maxSpeed = 40,
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
		}
	}

	return {
		enemiesOnMap = {},

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
			if #self.enemiesOnMap < 200 then
				if love.math.random() < 0.8 then
					self:spawn("normal")
				else
					self:spawn("hard")
				end
			end
			for i, enemy in ipairs(self.enemiesOnMap) do
				enemy:update(dt)
				for j = i, #self.enemiesOnMap do --, other_enemy in ipairs(self.enemiesOnMap) do
					other_enemy = self.enemiesOnMap[j]
					local collides, dx, dy = enemy.collider.collisionshape:collidesWith(other_enemy.collider.collisionshape)
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
