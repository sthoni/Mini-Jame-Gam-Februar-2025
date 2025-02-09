local font = love.graphics.getFont()

local pausing = {
	text = love.graphics.newText(font, "Press Return to unpause.\nPress q to quit."),
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
		love.graphics.draw(self.text, 260, 180)
	end
}

return pausing
