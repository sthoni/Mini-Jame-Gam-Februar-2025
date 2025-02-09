local font = love.graphics.getFont()

local menu = {
	text = love.graphics.newText(font, "Press Enter to begin!"),
	enter = function()
	end,
	exit = function()

	end,
	update = function(self, dt)
		if love.keyboard.isDown("return") then
			Game:set_state("running")
		end
	end,
	draw = function(self)
		love.graphics.draw(self.text, 260, 180)
	end
}

return menu
