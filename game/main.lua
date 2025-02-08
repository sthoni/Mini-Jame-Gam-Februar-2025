

function love.load()
	Object = require "lib//classic" --class imitation for lua
	local Player = require "src//player"

	player = Player(100, 100)
	print(player.test)
	love.keyboard.setKeyRepeat(true)
end

function love.update(dt)
	player:update(dt)
end

function love.draw()
	player:draw()
	love.graphics.rectangle("fill", 100, 100, 20, 10)
end
