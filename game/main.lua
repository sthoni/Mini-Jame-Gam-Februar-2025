local level = require "src.level"
local projectile = require "src.projectile"
local gamera = require "lib.gamera"
local push = require "lib.push"
Object = require "lib.classic" --class imitation for lua
require("lib.batteries"):export()
local Player = require "src.player"
local Enemy = require "src.enemy"

local gameWidth, gameHeight = 640, 360
local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth * .5, windowHeight * .5

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight,
	{ fullscreen = false, resizable = true, pixelperfect = true, highdpi = true })
love.graphics.setBackgroundColor(.714, .835, .235, 1)
push:setBorderColor(0, 0, 0, 1)

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	cam = gamera.new(0, 0, 6400, 3600)
	cam:setWindow(0, 0, 640, 360)

	level = level()
	projectile = projectile()
	player = Player(1000, 1000)
	enemy = Enemy(900, 1100)
	love.keyboard.setKeyRepeat(true)
end

function love.update(dt)
	player:update(dt)
	enemy:update(dt)
	projectile:update(dt)
	cam:setPosition(player.x, player.y)
end

function love.draw()
	push:start()
	cam:draw(function(l, t, w, h)
		level:draw()
		projectile:draw()
		enemy:draw()
		player:draw()
	end)
	push:finish()
end
