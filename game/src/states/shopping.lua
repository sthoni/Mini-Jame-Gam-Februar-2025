local font = love.graphics.getFont()

local shopping = {
	text = love.graphics.newText(font, "Shop is closed for now.\nPress Return to return (no pun intended)."),
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
		love.graphics.draw(self.text, 220, 180)
	end
}

return shopping
