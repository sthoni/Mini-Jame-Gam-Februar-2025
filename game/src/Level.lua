function Level()
	local LEVEL_WIDTH = 6400
	local LEVEL_HEIGHT = 3600

	local LEVEL_TILEMAP = love.graphics.newImage("assets/tiles.png")
	local LEVEL_TILEMAP_BATCH = love.graphics.newSpriteBatch(LEVEL_TILEMAP)
	local LEVEL_TILEMAP_GRASS = love.graphics.newQuad(34, 68, 16, 16, LEVEL_TILEMAP)
	local LEVEL_TILEMAP_BUSH = love.graphics.newQuad(0, 51, 16, 16, LEVEL_TILEMAP)
	local LEVEL_TILEMAP_TREE = love.graphics.newQuad(0, 68, 16, 16, LEVEL_TILEMAP)
	local LEVEL_TILEMAP_GRASS2 = love.graphics.newQuad(34, 153, 16, 16, LEVEL_TILEMAP)
	local LEVEL_TILEMAP_HOUSE = love.graphics.newQuad(0, 102, 16, 16, LEVEL_TILEMAP)
	local LEVEL_TILEMAP_HOUSE2 = love.graphics.newQuad(0, 119, 16, 16, LEVEL_TILEMAP)
	local LEVEL_TILEMAP_TREEDOUBLE = love.graphics.newQuad(0, 85, 16, 16, LEVEL_TILEMAP)


	local tiles = {}

	for baseY = 0, LEVEL_HEIGHT, 16 do
		for baseX = 0, LEVEL_WIDTH, 16 do
			local quad = (
			love.math.random() < .02 and LEVEL_TILEMAP_TREEDOUBLE or
			love.math.random() < .03 and LEVEL_TILEMAP_TREE or
			love.math.random() < .005 and LEVEL_TILEMAP_BUSH or
			love.math.random() < .001 and LEVEL_TILEMAP_HOUSE or
			love.math.random() < .001 and LEVEL_TILEMAP_HOUSE2 or
			love.math.random() < 0.1 and LEVEL_TILEMAP_GRASS or 
			love.math.random() < 0.1 and LEVEL_TILEMAP_GRASS2)
			if quad then
				table.insert(tiles, {
					quad = quad,
					x = baseX,
					y = baseY,
					serial = #tiles,
				})	
			end
			
		end
	end

	return {
		draw = function(self)		
			table.sort(tiles, function (tile1, tile2)
				if tile1.y ~= tile2.y then
					return tile1.y < tile2.y
				end
				return tile1.serial < tile2.serial
			end)

			LEVEL_TILEMAP_BATCH:clear()
			for _, tile in ipairs(tiles) do
				LEVEL_TILEMAP_BATCH:add(tile.quad, math.floor(tile.x), math.floor(tile.y))
			end
			love.graphics.draw(LEVEL_TILEMAP_BATCH)
		end
	}
end

return Level
