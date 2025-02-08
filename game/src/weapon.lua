-- Player hat Tabelle mit Waffen
-- Jeden Update geht Player Tabelle durch und fragt Waffen ab
-- Waffen spawnen Projektile
-- Waffe hat Eigenschaften, wie häufig Sachen gespawnt werden
-- Projektile moven und haben Kollision mit Effekt
-- Projektile können drawen

local function Weapon()
	local weaponsData = {
		machineGun = {
			name = "Machine Gun",
			baseDamage = 1,
			baseRate = .5,
			baseSpeed = 2,
			spriteX = 5,
			spriteY = 0,
			spriteWidth = 6,
			spriteHeight = 16,
			level = 1,
		},
		lazerGun = {
			name = "Lazer Gun",
			baseDamage = 3,
			baseRate = 2,
			baseSpeed = 10,
			spriteX = 39,
			spriteY = 1,
			spriteWidth = 6,
			spriteHeight = 14
		}
	}

	
	return {
		weaponsEquipped = {},
		createWeaponComponent = function (weapon)
			local weaponToCreate
			for key, value in pairs(weaponsData) do
				if key == weapon then
					weaponToCreate = value
				end
			end
			return weaponToCreate
		end,
		addWeapon = function (self, weapon)
			table.insert(self.weaponsEquipped, self.createWeaponComponent(weapon))	
		end
	}
end


return Weapon
