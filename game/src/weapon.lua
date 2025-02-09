-- Player hat Tabelle mit Waffen
-- Jeden Update geht Player Tabelle durch und fragt Waffen ab
-- Waffen spawnen Projektile
-- Waffe hat Eigenschaften, wie häufig Sachen gespawnt werden
-- Projektile moven und haben Kollision mit Effekt
-- Projektile können drawen

tick = require "lib.tick"
Projectile = require "src.projectile"

local function Weapon(x, y)
	local projectile = Projectile()
	local weaponsData = {
		machineGun = {
			name = "Machine Gun",
			baseDamage = 1,
			baseRate = 1,
			baseSpeed = 1000,
			spriteX = 52,
			spriteY = 19,
			spriteWidth = 13,
			spriteHeight = 11,
			level = 1,
		},
		lazerGun = {
			name = "Lazer Gun",
			baseDamage = 3,
			baseRate = 2,
			baseSpeed = 2000,
			spriteX = 39,
			spriteY = 1,
			spriteWidth = 6,
			spriteHeight = 14
		}
	}

	return {
		x = x,
		y = y,
		angle = 0,
		weaponsEquipped = {},
		createWeaponComponent = function(weaponType)
			local weaponToCreate
			for key, value in pairs(weaponsData) do
				if key == weaponType then
					weaponToCreate = value
				end
			end
			return weaponToCreate
		end,
		addWeapon = function(self, weaponType)
			local weaponToAdd = self.createWeaponComponent(weaponType)
			table.insert(self.weaponsEquipped, weaponToAdd)
			tick.recur(function()
				projectile.new(weaponToAdd.baseDamage, weaponToAdd.baseSpeed, self.x, self.y, self.angle,
					weaponToAdd.spriteX, weaponToAdd.spriteY, weaponToAdd.spriteWidth, weaponToAdd.spriteHeight)
			end, weaponToAdd.baseRate)
		end,
		update = function(self, dt, playerX, playerY, playerAngle)
			tick.update(dt)
			self.x = playerX
			self.y = playerY
			self.angle = playerAngle
		end
	}
end


return Weapon
