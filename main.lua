gamestate = require "src.gamestate"

local menu = require "src.menu"

function love.load()
    math.randomseed(os.clock())
    gamestate.registerEvents()
    gamestate.switch(menu)
end
