gamestate = require "src.gamestate"
local Enemy = require "src.Enemy"
local Astronaut = require "src.Astronaut"

local game = {}

-- Creating objects --
function game:enter()

   --creating background
   background = love.graphics.newImage("assets/background.png")
   backgroundx = -(love.graphics.getWidth() * 0.5)
   backgroundy = -(love.graphics.getHeight() * 0.5)
   
   
   -- creating enemies
   enemy1 = Enemy(15,50)
   enemy2 = Enemy(80,550)

   -- creating astronaut
   astronautSpeed = 250
   astronautX = love.graphics.getWidth() * 0.5
   astronautY = love.graphics.getHeight() * 0.5
   astronaut = Astronaut(astronautSpeed, astronautX, astronautY)
   
end


-- Function Update --
function game:update(dt)

   astronaut:update(dt)
   
   enemy1:update(dt, astronaut:getHorizontalPosition(), astronaut:getVerticalPosition())
   enemy2:update(dt, astronaut:getHorizontalPosition(), astronaut:getVerticalPosition())
   
end

-- Function Draw --
function game:draw()

   love.graphics.draw(background, backgroundx, backgroundy)
    
   astronaut:draw()
   
   enemy1:draw()
   enemy2:draw()
end


-- Leave The Game --
function game:leave()

end


return game
