game = require "src.game"
gamestate = require "src.gamestate"
local game = require "src.game"
local space = require "src.space"

local menu = {}

function menu:enter()
    gamestate.switch(space)
end

function menu:draw()

end

function menu:leave()

end

return menu
