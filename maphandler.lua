local maphandler = {}
local sti = require 'Libraries/sti'

-- We start with no map loaded
maphandler.gameMap = nil

function maphandler.load(mapPath)
    -- This allows you to call maphandler.load("Assets/Maps/Hallway.lua")
    maphandler.gameMap = sti(mapPath)
end

return maphandler