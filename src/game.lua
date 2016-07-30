gamestate = require "src.gamestate"
local Enemy = require "src.Enemy"

local game = {}

function game:enter()
    enemy1 = Enemy(15,50)
    enemy2 = Enemy(80,550)
    playerX = 500
    playerY = 300
end

function game:update(dt)
    enemy1:move(dt, playerX, playerY)
    enemy2:move(dt, playerX, playerY)
    playerX = playerX - 1
end

function game:draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle('fill', playerX, playerY, 70, 70)
    love.graphics.setColor(255, 255, 255)
    enemy1:draw()
    enemy2:draw()
end

function game:leave()

end

return game
