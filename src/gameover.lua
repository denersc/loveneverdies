gamestate = require "src.gamestate"

local gameover = {}
local menu = require "src.menu"


function gameover:enter()
    gameoverImg = love.graphics.newImage("assets/gameoverImg.png")

    --gamestate.switch(space)
end

function gameover:draw()
    love.graphics.draw(gameoverImg, 0, 0)
end

function gameover:update(dt)
    if love.mouse.isDown("1") or love.keyboard.isDown("return") then
        gamestate.switch(menu)
    end
end

function gameover:leave()

end

return gameover
