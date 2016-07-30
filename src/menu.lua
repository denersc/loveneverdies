gamestate = require "src.gamestate"
local game = require "src.game"
local menu = {}

function menu:enter()
    gamestate.switch(game)
end

function menu:draw()

end

function menu:leave()

end

return menu
