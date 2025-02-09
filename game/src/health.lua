local function Health(baseHp)
	local barWidth = 20
	local barHeigth = 5

	return {
		maxHp = baseHp,
		hp = baseHp,
		takeDamage = function(self, damage)
			self.hp = self.hp - damage
			if self.hp < 0 then
				self.hp = 0
			end
		end,
		draw = function(self)
			love.graphics.setColor(.1, .1, .1, 1)
			love.graphics.rectangle("fill", -11, 18, barWidth, barHeigth)
			love.graphics.setColor(1, 0, 0, 1)
			love.graphics.rectangle("fill", -11, 18, barWidth * (self.hp / self.maxHp), barHeigth)
			love.graphics.setColor(1, 1, 1, 1)
		end
	}
end

return Health
