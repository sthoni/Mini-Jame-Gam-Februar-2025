require "src.constants"
require("lib.batteries"):export()
Object = require "lib.classic" --class imitation for lua
HC = require 'lib.HC'
local gamera= require "lib.gamera"
local push = require "lib.push"
local Level = require "src.level"
local Player = require "src.player"
local gameWidth, gameHeight = 640, 360
local windowWidth, windowHeight = love.window.getDesktopDimensions()
local Projectile = require "src.projectile"
local EnemyManager = require "src.enemyManager"


windowWidth, windowHeight = windowWidth * .5, windowHeight * .5
push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight,
{ fullscreen = false, resizable = true, pixelperfect = true, highdpi = true })
push:setBorderColor(0, 0, 0, 1)
love.graphics.setBackgroundColor(.714, .835, .235, 1)

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	Collider = HC.new(150)
	cam = gamera.new(0, 0, 6400, 3600)
	cam:setWindow(0, 0, 640, 360)
	enemyManager = EnemyManager()
	level = Level()
	projectile = Projectile()
	player = Player(PLAYER_SPAWN_POINT_X, PLAYER_SPAWN_POINT_Y)
	love.keyboard.setKeyRepeat(true)
    Rect = Collider:rectangle(PLAYER_SPAWN_POINT_X,PLAYER_SPAWN_POINT_Y + 200,50,50)
end

function love.update(dt)
	player:update(dt)
	enemyManager:update(dt)
	projectile:update(dt)
	cam:setPosition(player.x, player.y)
end

function love.draw()
	push:start()
	-- shapes can be drawn to the screen
	love.graphics.setColor(255,255,255)
	cam:draw(function(l, t, w, h)
		level:draw()
		projectile:draw()
		enemyManager:draw()
		player:draw()
		-- Rect:draw('fill')
		-- player.collisionshape:draw('fill')
	end)
	push:finish()    
end
