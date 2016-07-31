gamestate = require "src.gamestate"
local Enemy = require "src.Enemy"
local Astronaut = require "src.Astronaut"
local Unicorn = require "src.Unicorn"
local Hud = require "src.Hud"
local gameover = require "src.gameover"


local game = {}
local unicorns = {}
local llamas = {}

-- Creating objects --
function game:enter()

   --creating background
   background = love.graphics.newImage("assets/background.png")
   backgroundx = -(love.graphics.getWidth() * 0.5)
   backgroundy = -(love.graphics.getHeight() * 0.5)

   --creating hud
   hud = Hud()
   for i=1, 4, 1 do
      hud:addHeart()
   end

   -- gerar a população de unicornios e inimigos
   game:populateUnicorns()
   game:populateLlamas()

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

	for i,unicorn in pairs(unicorns) do 
		unicorn:update(dt, astronaut, background)
	end
	for i,llama in pairs(llamas) do 
		llama:update(dt, astronaut:getHorizontalPosition() + astronaut:getImage():getWidth()/2, astronaut:getVerticalPosition() + astronaut:getImage():getHeight()/2)
	end
end

-- Function Draw --
function game:draw()

   love.graphics.draw(background, backgroundx, backgroundy)

   astronaut:draw()

	for i,unicorn in pairs(unicorns) do 
		unicorn:draw(backgroundx, backgroundy)
	end
	for i,llama in pairs(llamas) do
		llama:draw()
	end

   love.graphics.setColor(0, 0, 0)
   love.graphics.print("Tempo: " .. self.totalTime, 713, 37)
   love.graphics.setColor(255, 255, 255)
   love.graphics.print("Tempo: " .. self.totalTime, 714, 36)

   hud:draw()
end


-- Leave The Game --
function game:leave()

end

function game:populateUnicorns()
	for i=0, currentMission[0]+math.random(1,3) do
		newUnicorn = Unicorn(math.random(0,background:getWidth()), math.random(0,background:getHeight()), 0)
		table.insert(unicorns, newUnicorn)
	end
	for i=0, currentMission[1]+math.random(1,3) do
		newUnicorn = Unicorn(math.random(0,background:getWidth()), math.random(0,background:getHeight()), 1)
		table.insert(unicorns, newUnicorn)
	end
	for i=0, currentMission[2]+math.random(1,2) do
		newUnicorn = Unicorn(math.random(0,background:getWidth()), math.random(0,background:getHeight()), 2)
		table.insert(unicorns, newUnicorn)
	end
	for i=0, currentMission[3]+math.random(0,2) do
		newUnicorn = Unicorn(math.random(0,background:getWidth()), math.random(0,background:getHeight()), 3)
		table.insert(unicorns, newUnicorn)
	end
	for i=0, currentMission[4]+math.random(0,1) do
		newUnicorn = Unicorn(math.random(0,background:getWidth()), math.random(0,background:getHeight()), 4)
		table.insert(unicorns, newUnicorn)
	end
end

function game:populateLlamas()
	for i=0, 1 do
		newLlama = Enemy(math.random(0,background:getWidth()), math.random(0,background:getHeight()))
		table.insert(llamas, newLlama)
	end
end

return game
