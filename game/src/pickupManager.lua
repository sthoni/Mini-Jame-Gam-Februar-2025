local Pickup = require "src.pickup"

local function getRandomPickups(amount)
	local pickups = {}
	for i = 0, amount do
		local pickup = Pickup(love.math.random(50, 6350), love.math.random(30, 3550))
		table.insert(pickups, pickup)
	end
	return pickups
end

local function PickupManager()
	return {
		pickupsOnMap = getRandomPickups(100),
		draw = function(self)
			for _, pickup in pairs(self.pickupsOnMap) do
				pickup:draw()
			end
		end,

		spawn = function(self, position)
			local pickup = Pickup(position.x, position.y)
			table.insert(self.pickupsOnMap, pickup)
		end,

		update = function(self, dt)
			for key, pickup in pairs(self.pickupsOnMap) do
				local playerPosition = vec2(player.x, player.y)
				if pickup.position:distance(playerPosition) < 50 then
					player.xp = player.xp + 1
					player.maxSpeed = player.maxSpeed + 8
					player.health:heal(2)
					player.speed.abs = player.speed.abs + 8
					self.pickupsOnMap[key] = nil
				end
			end
		end
	}
end

return PickupManager
