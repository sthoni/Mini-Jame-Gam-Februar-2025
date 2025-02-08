local level = require "src.level"

function love.load()
	Object = require "lib//classic" --class imitation for lua
	local Player = require "src//player"
	
	level = Level()
	player = Player(100, 100)
	print(player.test)
	love.keyboard.setKeyRepeat(true)
end

function love.update(dt)
	player:update(dt)
end

function love.draw()
	player:draw()
end
