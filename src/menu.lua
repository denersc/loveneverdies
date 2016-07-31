game = require "src.game"
gamestate = require "src.gamestate"
local game = require "src.game"
local space = require "src.space"

local menu = {}

function menu:enter()
    start = love.graphics.newImage("assets/start.png")
    about = love.graphics.newImage("assets/about.png")
    menuBackground = love.graphics.newImage("assets/menu-fundo.png")
    
    --gamestate.switch(space)
end

function menu:draw()
    love.graphics.draw(menuBackground, 0, 0)
    love.graphics.draw(start, 40, 300)
    love.graphics.draw(about, 600, 300)
end

function menu:update(dt)
    if love.mouse.isDown("1") then
       x = love.mouse.getX()
       y = love.mouse.getY()
       
       if (x > 40 and x < 200) and (y > 300 and y < 415) then
           gamestate.switch(space)
       end
    end
end

function menu:leave()

end

return menu
