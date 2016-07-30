gamestate = require "src.gamestate"

local menu = {}

function menu:enter()
    rcg = love.graphics.newImage("assets/rcg.png")
end

function menu:draw()
    love.graphics.draw(rcg)
end

function menu:leave()
    rcg = nil
end

return menu
