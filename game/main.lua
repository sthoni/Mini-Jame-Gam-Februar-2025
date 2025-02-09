local push = require "lib.push"
Object = require "lib.classic" --class imitation for lua
require("lib.batteries"):export()

local Player = require "src.player"
local running = require "src.states.running"
local menu = require "src.states.menu"
local pausing = require "src.states.pausing"
local shopping = require "src.states.shopping"

local gameWidth, gameHeight = 640, 360
local windowWidth, windowHeight = gameWidth, gameHeight
local IS_DEBUG = os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" and arg[2] == "debug"
if IS_DEBUG then
	windowWidth, windowHeight = love.window.getDesktopDimensions()
	windowWidth, windowHeight = windowWidth * .5, windowHeight * .5
end
push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight,
	{ fullscreen = false, resizable = false, pixelperfect = true, highdpi = true })
love.graphics.setBackgroundColor(.714, .835, .235, 1)
push:setBorderColor(0, 0, 0, 1)

function love.resize(w, h)
	return push:resize(w, h)
end

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	player = Player(1000, 1000, 20, 70)
	Game = state_machine({ running = running, menu = menu, pausing = pausing, shopping = shopping }, "menu")
	local music = love.audio.newSource("assets/Mission Plausible.ogg", "stream")
	music:setLooping(true)
	music:setVolume(0.1)
	music:play()
end

function love.update(dt)
	Game:update(dt)
end

function love.draw()
	push:start()
	Game:draw()
	push:finish()
end
