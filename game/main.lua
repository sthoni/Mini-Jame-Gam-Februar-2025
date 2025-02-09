require "src.constants"
local gamera= require "lib.gamera"
local push = require "lib.push"
HC = require 'lib.HC'
local Level = require "src.level"
local Projectile = require "src.projectile"
Object = require "lib.classic" --class imitation for lua
require("lib.batteries"):export()
local Player = require "src.player"
local EnemyManager = require "src.enemyManager"

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
	enemyManager = EnemyManager()
	level = Level()
	projectile = Projectile()
	player = Player(PLAYER_SPAWN_POINT_X, PLAYER_SPAWN_POINT_Y)
	love.keyboard.setKeyRepeat(true)
	Collider = HC.new(500)
    Rect = Collider:rectangle(PLAYER_SPAWN_POINT_X,PLAYER_SPAWN_POINT_Y + 200,50,50)
	player.collisionshape = Collider:circle(PLAYER_SPAWN_POINT_X,PLAYER_SPAWN_POINT_Y, 8)
end

function love.update(dt)
	--process collisions:
	for shape, delta in pairs(Collider:collisions(player.collisionshape)) do
    	print("collision")
		shape:move(delta.x*2, delta.y*2)
		player.collision_move(delta.x, delta.y)
	end

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
		Rect:draw('fill')
		player.collisionshape:draw('fill')
	end)
	push:finish()    
end
