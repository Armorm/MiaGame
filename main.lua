Timer = require "Libraries.timer"
timer = Timer.new()

local Gamestate = require("Libraries/gamestate")
local menu = require("menuMain")
local firstact = require("firstAct")

function love.load()
 function love.keypressed(key, scancode, isrepeat)
    Gamestate.keypressed(key, scancode, isrepeat)
end

 love.graphics.setDefaultFilter("nearest", "nearest") 
 love.window.setMode(800, 480)
 Canvas = love.graphics.newCanvas(400, 240)
 
 Gamestate.switch(menu)
 
end

function love.update(dt)
 timer:update(dt)
 Gamestate.update(dt)
end

function love.draw()
 love.graphics.setCanvas(Canvas)
 love.graphics.clear(0.1, 0.1, 0.12)
 
 Gamestate.current():draw()

 love.graphics.setCanvas()
 love.graphics.draw(Canvas, 0, 0, 0, 2, 2)
end