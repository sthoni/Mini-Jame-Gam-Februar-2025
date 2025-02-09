local Pickup = require "src.pickup"

local function PickupManager()
	return {
		pickupsOnMap = {},
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
					self.pickupsOnMap[key] = nil
				end
			end
		end
	}
end

return PickupManager
