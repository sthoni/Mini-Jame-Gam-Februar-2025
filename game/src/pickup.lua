local function Pickup(x, y)
	local pickup_tilemap = love.graphics.newImage("assets/tiles.png")
	local spriteX = 19
	local spriteY = 35
	local spriteWidth = 11
	local spriteHeigth = 13
	local quad = love.graphics.newQuad(spriteX, spriteY, spriteWidth, spriteHeigth, pickup_tilemap)

	return {
		position = vec2(x, y),

		draw = function(self)
			love.graphics.push("all")
			love.graphics.translate(self.position.x + spriteWidth / 2, self.position.y + spriteWidth / 2)
			love.graphics.draw(pickup_tilemap, quad, -spriteHeigth / 2, -spriteWidth / 2)
			love.graphics.pop()
		end,
	}
end

return Pickup
