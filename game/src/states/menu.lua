local font = love.graphics.getFont()

local menu = {
	text = love.graphics.newText(font,
		"Controls: Press up to accelerate, down to reverse.\nPress left and right to steer.\nPress Enter to begin!\nPress q to quit."),
	enter = function()
	end,
	exit = function()

	end,
	update = function(self, dt)
		if love.keyboard.isDown("return") then
			Game:set_state("running")
		elseif love.keyboard.isDown("q") then
			love.event.quit()
		end
	end,
	draw = function(self)
		love.graphics.draw(self.text, 180, 160)
	end
}

return menu
