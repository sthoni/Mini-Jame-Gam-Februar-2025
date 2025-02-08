local level = require "src.level"
local gamera= require "lib.gamera"
local push = require "lib.push"
HC = require 'lib.HC'

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
	
	level = Level()
	player = Player(1000, 1000)
	player.collider = HC.circle(1000,1000,8)
	print(player.test)
	love.keyboard.setKeyRepeat(true)
end

function love.update(dt)
	--process collisions:
	for shape, delta in pairs(HC.collisions(player)) do
    	print("collision")
		-- shape:move(delta.x, delta.y)
	end

	player:update(dt)
	cam:setPosition(player.x, player.y)
end

function love.draw()
	push:start()
	cam:draw(function (l, t, w, h)
		level:draw()
		player:draw()
	end)
	push:finish()
end
