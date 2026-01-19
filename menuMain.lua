local Gamestate = require("Libraries/gamestate")
local menu = {}
local canvasWidth = 400
local canvasHeight = 240 
local sun = {radius = 64, Xposition = canvasWidth/2, Yposition = canvasHeight/2}
local sunsprite = love.graphics.newImage("Assets/Sprites/solar eclipse.png")
sunsprite:setFilter("nearest", "nearest")
local glowsprite = love.graphics.newImage("Assets/Sprites/Blur.png")
local ServicePlanetSprite = love.graphics.newImage("Assets/Sprites/Planet1.png")
local background = love.graphics.newImage("Assets/Sprites/")
local planets = {
service = {sprite = ServicePlanetSprite, Xposition = 300 - ServicePlanetSprite:getWidth()/2, Yposition = 120 - ServicePlanetSprite:getHeight()/2, orbit = 125, sizemult = 1, angle = 0, speed = 0.5 }
}


function menu:update(dt)
 for _, planet in pairs(planets) do
     local centrex = sun.Xposition
     local centrey = sun.Yposition
     planet.Xposition = centrex + math.cos(planet.angle) * planet.orbit
     planet.Yposition = centrey + math.sin(planet.angle) * planet.orbit
     planet.angle = planet.angle + planet.speed * dt
 end
 
end

function menu.draw()
 love.graphics.clear (0.05, 0.05, 0.1)
 love.graphics.setBlendMode("add")
 love.graphics.setColor(0.4, 0, 0, 0.6)
 local pulse = 1 + math.sin(love.timer.getTime() * 2) * 0.1
 love.graphics.draw(glowsprite, sun.Xposition, sun.Yposition, 0, (8 * pulse)*0.3, (8 * pulse)*0.3, 64, 64)
 
 love.graphics.setColor(1, 1, 1, 0.5)
 for _, planet in pairs(planets) do
    love.graphics.draw(planet.sprite, planet.Xposition, planet.Yposition)
 end
 love.graphics.setColor(1, 1, 1, 1)
 love.graphics.setBlendMode("alpha")
 love.graphics.draw(sunsprite, sun.Xposition - sunsprite:getWidth(), sun.Yposition - sunsprite:getHeight(), 0, 2)

end

function menu.keypressed(key)
    if key == "s" then
        Gamestate.switch(require("firstAct"))
    end
end

return menu

