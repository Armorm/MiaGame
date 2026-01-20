local Gamestate = require("Libraries/gamestate")
local menu = {}
local canvasWidth = 400
local canvasHeight = 240 
local sun = {scale = 1, Xposition = canvasWidth/2, Yposition = canvasHeight/2, ontop = false}
local sunsprite = love.graphics.newImage("Assets/Sprites/solar eclipse.png")
sunsprite:setFilter("nearest", "nearest")
local glowsprite = love.graphics.newImage("Assets/Sprites/Blur.png")
local ServicePlanetSprite = love.graphics.newImage("Assets/Sprites/Planet1.png")
local deltaruneFont = love.graphics.newFont("Assets/Fonts/deltarune.ttf",24)
local GiftPlanetSprite = love.graphics.newImage("Assets/Sprites/Planet2.png")
local background = love.graphics.newImage("Assets/Sprites/SpaceBackground.png")
local planets = {
service = {sprite = ServicePlanetSprite, Xposition = 600 - ServicePlanetSprite:getWidth()/2, Yposition = 120 - ServicePlanetSprite:getHeight()/2, orbit = 100, sizemult = 1, angle = 0, speed = 0.3 },
gift = {sprite = GiftPlanetSprite, Xposition = 300 - ServicePlanetSprite:getWidth()/2, Yposition = 120 - ServicePlanetSprite:getHeight()/2, orbit = 150, sizemult = 1, angle = 0, speed = 0.15 }

}


function menu:update(dt)
 for _, planet in pairs(planets) do
     local centrex = sun.Xposition - 20
     local centrey = sun.Yposition
     planet.Xposition = centrex + math.cos(planet.angle) * planet.orbit
     planet.Yposition = centrey + math.sin(planet.angle) * planet.orbit
     planet.angle = planet.angle + planet.speed * dt
 end
 if sun.scale > 4.5 then
    Gamestate.switch(require("firstAct"))
 end
 
end

function menu.draw()
 love.graphics.clear (0.01, 0.01, 0.02)
 love.graphics.setBlendMode("alpha")

 love.graphics.setFont(deltaruneFont)

 love.graphics.setColor(0.3, 0.3, 0.3, 1)
 love.graphics.draw(background)

  
 
 love.graphics.setBlendMode("add")
  love.graphics.setColor(0.8, 0.8, 0.8, 1)
 for _, planet in pairs(planets) do
    love.graphics.draw(planet.sprite, planet.Xposition, planet.Yposition)
 end

 
 love.graphics.setColor(0.25, 0, 0, 1)
 local pulse = 1 + math.sin(love.timer.getTime() * 2) * 0.1
 love.graphics.draw(glowsprite, sun.Xposition, sun.Yposition, 0, (8 * pulse)*0.25, (8 * pulse)*0.25, 64, 64)

 



 love.graphics.setColor(0.85, 0.7, 0.7, 1)
 love.graphics.setBlendMode("alpha")

 if sun.ontop == false then
     love.graphics.draw(sunsprite, sun.Xposition - sunsprite:getWidth()*sun.scale, sun.Yposition - sunsprite:getHeight()*sun.scale, 0, 2)
 end


 love.graphics.setColor(1, 1, 1, 1)

 love.graphics.print("Press", math.floor(50), math.floor(canvasHeight/2- 10))
 love.graphics.print("Select", math.floor(290), math.floor(canvasHeight/2- 10))

  if sun.ontop == true then
     love.graphics.setColor(0.85, 0.7, 0.7, 1)
     love.graphics.draw(sunsprite, sun.Xposition - sunsprite:getWidth()*sun.scale, sun.Yposition - sunsprite:getHeight()*sun.scale, 0, 2*sun.scale)
     love.graphics.setColor(1, 1, 1, 1)
 end

end

function menu:keypressed(key)
    if key == "s" then
        sun.ontop = true
        timer:tween(3, sun, {scale = 5}, "in-cubic")
    end
end

return menu

