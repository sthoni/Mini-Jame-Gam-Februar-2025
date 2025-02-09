require "src.constants"
require("lib.batteries"):export()
Object = require "lib.classic" --class imitation for lua
HC = require 'lib.HC'
local gamera= require "lib.gamera"
local push = require "lib.push"
local Level = require "src.level"
local Player = require "src.player"
local PickupManager = require "src.pickupManager"

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
	player = Player(PLAYER_SPAWN_POINT_X, PLAYER_SPAWN_POINT_Y, 20, 60)
	pickupManager = PickupManager()
	pickupManager:spawn(vec2(1100, 1100))
	love.keyboard.setKeyRepeat(true)
	local music = love.audio.newSource("assets/Mission Plausible.ogg", "stream")
	music:setLooping(true)
	music:setVolume(0.1)
	music:play()
end

function love.update(dt)
	player:update(dt)
	enemyManager:update(dt)
	projectile:update(dt)
	pickupManager:update(dt)
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
		pickupManager:draw()
	end)
	push:finish()    
end
