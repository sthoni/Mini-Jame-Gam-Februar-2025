local IS_DEBUG = os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" and arg[2] == "debug"
if IS_DEBUG then
	require("lldebugger").start()

	function love.errorhandler(msg)
		error(msg, 2)
	end
end

HC = require 'lib.HC'

-- array to hold collision messages
local text = {}

function love.load()
    -- add a rectangle to the scene
	collider = HC.new(300)
    rect = collider:rectangle(200,400,400,20)

    -- add a circle to the scene
    mouse = collider:circle(400,300,20)
    mouse:moveTo(love.mouse.getPosition())
end

function love.update(dt)
    -- move circle to mouse position
    mouse:moveTo(love.mouse.getPosition())

    -- rotate rectangle
    rect:rotate(dt)

    -- check for collisions
    for shape, delta in pairs(collider:collisions(mouse)) do
        text[#text+1] = string.format("Colliding. Separating vector = (%s,%s)",
                                      delta.x, delta.y)
    end

    while #text > 40 do
        table.remove(text, 1)
    end
end

function love.draw()
    -- print messages
    for i = 1,#text do
        love.graphics.setColor(255,255,255, 255 - (i-1) * 6)
        love.graphics.print(text[#text - (i-1)], 10, i * 15)
    end

    -- shapes can be drawn to the screen
    love.graphics.setColor(255,255,255)
    rect:draw('fill')
    mouse:draw('fill')
end
