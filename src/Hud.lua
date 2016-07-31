local class = require 'src.30log'
local Heart = require 'src.Heart'
local Hud = class('src.Hud')

function Hud:init()
   self.x = 10
   self.y = 10
   --self.image = love.graphics.newImage("assets/hud.png")
   self.hearts = {}
end


function Hud:addHeart()

   heartVerticalPosition = 20
   heartHorizontalPosition = 20
   
   numberOfElements = table.getn(self.hearts)
   if numberOfElements==0 then
      heart = Heart(heartHorizontalPosition, heartVerticalPosition)
      table.insert(self.hearts, heart)
   else
      position = numberOfElements
      heartHorizontalPosition = self.hearts[position]:getHorizontalPosition() + 30
      heart = Heart(heartHorizontalPosition, heartVerticalPosition)
      table.insert(self.hearts, heart)
   end
end


function Hud:removeHeart()
   
   if table.getn(self.hearts) < 0 then
      return
   end
   
   position = table.getn(self.hearts)
   table.remove(self.hearts, position)
   
end


function Hud:draw()

   for i, heart in ipairs(self.hearts) do
      love.graphics.draw(heart:getImage(),
			 heart:getHorizontalPosition(),
			 heart:getVerticalPosition())
   end
   
end

      
return Hud
