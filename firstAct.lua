local Gamestate = require("Libraries/gamestate")
local PlayerTopDown = require("PlayerTopDown")
local collisionhandler = require("collisionhandler")
local camhandler = require("camhandler")

local firstAct = {}

function firstAct:enter()
    collisionhandler.load(PlayerTopDown, "Assets/Maps/MiaRoom1.lua")
end

function firstAct:update(dt)
    PlayerTopDown.update(dt)
    camhandler.update(dt)
end

function firstAct:draw()
    camhandler.draw()
end

return firstAct