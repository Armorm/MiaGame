local camhandler = {}
camhandler.__index = camhandler
local camera = require "Libraries.camera"
local cam = camera()
local PlayerTopDown = require("PlayerTopDown")
local maphandler = require("maphandler")


function camhandler.update(dt)
    cam:lookAt(math.floor(PlayerTopDown.x + 200 + 10), math.floor(PlayerTopDown.y + 132))
end

function camhandler.draw()
    local gameMap = maphandler.gameMap

    cam:attach()
-- 1. BOTTOM LAYERS (Floor/Ground)
        gameMap:drawLayer(gameMap.layers["Tile Layer 1"])
        gameMap:drawLayer(gameMap.layers["Carpet"])

        -- 2. COLLIDERS LAYER (Move this HERE)
        -- Drawing it before the player ensures the player walks "on top" of it
        if gameMap.layers["Coliders"] then
            gameMap:drawLayer(gameMap.layers["Coliders"])
        end

        -- 3. Y-SORTING (Player and furniture)
        local items = {}
        table.insert(items, {y = PlayerTopDown.y, draw = function() PlayerTopDown.draw() end})

        if gameMap.layers["Sortables"] then
            for _, obj in ipairs(gameMap.layers["Sortables"].objects) do
                table.insert(items, {
                    y = obj.y, 
                    draw = function() gameMap:drawObject(obj) end
                })
            end
        end

        table.sort(items, function(a, b) return a.y < b.y end)
        for _, item in ipairs(items) do
            item.draw()
        end

        -- 4. OVERHEAD LAYER (Things the player walks UNDER)
        if gameMap.layers["Abobe"] then
            gameMap:drawLayer(gameMap.layers["Abobe"])
        end
    cam:detach()
end

return camhandler