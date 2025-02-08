local level = require "src.level"
local projectile = require "src.projectile"
local gamera= require "lib.gamera"
local push = require "lib.push"

local gameWidth, gameHeight = 640, 360
local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth * .7, windowHeight * .7

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, pixelperfect = true})
push:setBorderColor(.714, .835, .235, 1)


function love.load()
	love.graphics.setDefaultFilter( 'nearest', 'nearest' )
	Object = require "lib//classic" --class imitation for lua
	local Player = require "src//player"
	cam = gamera.new(0, 0, 6400, 3600)
	cam:setWindow(0,0,640,360)


	level = level()
	projectile = projectile()
	player = Player(1000, 1000)
	print(player.test)
	love.keyboard.setKeyRepeat(true)
end

function love.update(dt)
	player:update(dt)
	projectile:update(dt)
	cam:setPosition(player.x, player.y)
end

function love.draw()
	push:start()
	cam:draw(function (l, t, w, h)
		level:draw()
		projectile:draw()
		player:draw()
	end)
	push:finish()
end
