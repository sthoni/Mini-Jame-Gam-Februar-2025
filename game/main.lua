local level = require "src.level"

function love.load()
	level = Level()
end

function love.update()
end

function love.draw()
	level:draw()
end
