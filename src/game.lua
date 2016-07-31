gamestate = require "src.gamestate"
local Enemy = require "src.Enemy"
local Astronaut = require "src.Astronaut"
local Unicorn = require "src.Unicorn"
local Hud = require "src.Hud"
local gameover = require "src.gameover"


local game = {}

-- Creating objects --
function game:enter()

   --creating background
   background = love.graphics.newImage("assets/chao/chao1.png")
   backgroundx = -100
   backgroundy = 20

   --creating hud
   hud = Hud()
   for i=1, 4, 1 do
      hud:addHeart()
   end

   -- creating enemies
   enemy1 = Enemy(15,50)
   --enemy2 = Enemy(680,550)

   -- creating a unicorn
   unicorn1 = Unicorn(500,500,0)

   -- creating astronaut
   astronautSpeed = 250
   astronautX = love.graphics.getWidth() * 0.5
   astronautY = love.graphics.getHeight() * 0.5
   astronaut = Astronaut(astronautSpeed, astronautX, astronautY)

   --setting timer
   self.totalTime = 60
   self.time = 0
end


-- Function Update --
function game:update(dt)
   self.time = self.time + dt
   if self.time >= 1 then
       self.time = 0
       self.totalTime = self.totalTime - 1
   end

   if self.totalTime <= 0 then
       currentMissionNumber = nil
       currentMissionComplete = false
       currentMoney = 0
       gamestate.switch(gameover)
   end

   if astronaut:getLife() == 0 then
      currentMissionNumber = nil
      currentMissionComplete = false
      currentMoney = 0
      gamestate.switch(gameover)
   end

   astronaut:update(dt)

   enemy1:update(dt, astronaut:getHorizontalPosition() + astronaut:getImage():getWidth()/2, astronaut:getVerticalPosition() + astronaut:getImage():getHeight()/2)
   --enemy2:update(dt, astronaut:getHorizontalPosition() + astronaut:getImage():getWidth()/2, astronaut:getVerticalPosition() + astronaut:getImage():getHeight()/2)

   unicorn1:update(dt, astronaut)
end

-- Function Draw --
function game:draw()

   love.graphics.draw(background, backgroundx, backgroundy)

   astronaut:draw()

   enemy1:draw()
   --enemy2:draw()

   unicorn1:draw(backgroundx, backgroundy)

   love.graphics.setColor(0, 0, 0)
   love.graphics.print("Tempo: " .. self.totalTime, 713, 37)
   love.graphics.setColor(255, 255, 255)
   love.graphics.print("Tempo: " .. self.totalTime, 714, 36)

   hud:draw()
end


-- Leave The Game --
function game:leave()

end

return game
