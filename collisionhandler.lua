local collisionhandler = {}
local bump = require "Libraries.bump"
local maphandler = require("maphandler")

-- We keep the world variable here
local world = bump.newWorld(32)

function collisionhandler.load(player, mapPath)
    -- 1. Clear the old world and create a fresh one
    world = bump.newWorld(32)
    
    -- 2. Load the actual map file
    maphandler.load(mapPath)
    local gameMap = maphandler.gameMap
    if not gameMap then return end

    -- 3. Add the player to the NEW world
    world:add(player, player.x, player.y, player.width, player.height)

    -- 4. Load Tile Colliders
    if gameMap.layers["Coliders"] then
        for y, row in ipairs(gameMap.layers["Coliders"].data) do
            for x, tile in ipairs(row) do
                if tile then
                    world:add({isWall = true}, (x-1)*gameMap.tilewidth, (y-1)*gameMap.tileheight, gameMap.tilewidth, gameMap.tileheight)
                end
            end
        end
    end

    -- 5. Load Object Colliders
    if gameMap.layers["Object Layer 1"] then
        for _, obj in ipairs(gameMap.layers["Object Layer 1"].objects) do
            world:add({isWall = true}, obj.x, obj.y, obj.width, obj.height)
        end
    end
end

function collisionhandler.getWorld()
    return world
end

return collisionhandler