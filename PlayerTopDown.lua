local PlayerTopDown = {}
PlayerTopDown.__index = PlayerTopDown
PlayerTopDown.spritesheet = love.graphics.newImage("Assets/Sprites/spritesheet.png")
local anim8 = require 'Libraries/anim8'
PlayerTopDown.x = 50
PlayerTopDown.y = 50
-- Define the hitbox size (feet area)
PlayerTopDown.width = 32
PlayerTopDown.height = 16 
local speed = 100
PlayerTopDown.grid = anim8.newGrid(32, 32, PlayerTopDown.spritesheet:getWidth(), PlayerTopDown.spritesheet:getHeight())

PlayerTopDown.animations = {}
PlayerTopDown.animations.down = anim8.newAnimation(PlayerTopDown.grid('1-2', 1), 0.4)
PlayerTopDown.animations.up = anim8.newAnimation(PlayerTopDown.grid('1-2', 2), 0.4)
PlayerTopDown.animations.right = anim8.newAnimation(PlayerTopDown.grid('1-2', 3), 0.4)
PlayerTopDown.animations.left = anim8.newAnimation(PlayerTopDown.grid('1-2', 4), 0.4)

local listAnimations = {PlayerTopDown.animations.down, PlayerTopDown.animations.up, PlayerTopDown.animations.left, PlayerTopDown.animations.right}
local IFCAni = 1

local function playerFilter(item, other)
    if other.isWall then return 'slide' end
    return nil -- ignore everything else
end

function PlayerTopDown.update(dt)
    local dx, dy = 0, 0
    local speed = 100

    -- 1. Just collect the INTENT (don't change x/y yet!)
    if love.keyboard.isDown("right") then dx = speed * dt IFCAni = 4 end
    if love.keyboard.isDown("left")  then dx = -speed * dt IFCAni = 3 end
    if love.keyboard.isDown("down")  then dy = speed * dt IFCAni = 1 end
    if love.keyboard.isDown("up")    then dy = -speed * dt IFCAni = 2 end 

    -- 2. Fix diagonal speed
    if dx ~= 0 and dy ~= 0 then
        dx = dx / math.sqrt(2)
        dy = dy / math.sqrt(2)
    end

   if dx ~= 0 or dy ~= 0 then
        local coll = require("collisionhandler")
        local world = coll.getWorld()
        
        local goalX = PlayerTopDown.x + dx
        local goalY = PlayerTopDown.y + dy

        -- ADD THE FILTER HERE as the 4th argument
        local actualX, actualY, cols, len = world:move(PlayerTopDown, goalX, goalY, playerFilter)

        PlayerTopDown.x = actualX
        PlayerTopDown.y = actualY
    end
    PlayerTopDown.animations.down:update(dt)
end

function PlayerTopDown.draw()
    -- Subtract height so the "feet" of the sprite match the collision box
    -- If sprite is 32x32 and collision is 16 tall, offset Y by 16.
    listAnimations[IFCAni]:draw(PlayerTopDown.spritesheet, math.floor(PlayerTopDown.x), math.floor(PlayerTopDown.y - 16))
end

return PlayerTopDown