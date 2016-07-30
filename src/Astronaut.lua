local class = require 'src.30log'
local Astronaut = class("Astronaut")

-- Astronaut Constructor --
function Astronaut:init(speed, x, y)

   --movement
   self.speed = speed
   self.x = x
   self.y = y

   --image
   self.image = love.graphics.newImage("assets/astronaut.png")
   
end


-- Set Astronaut Image --
function Astronaut:setImage(imagePath)
   self.image = love.graphics.newImage(imagePath)   
end


-- Get Astronaut Image --
function Astronaut:getImage()
   return self.image
end


-- Set Astronaut Position --
function Astronaut:setPosition(x, y)
   self.x = x
   self.y = y   
end


-- Get Astronaut Vertical Position --
function Astronaut:getVerticalPosition()
   return self.y
end


-- Get Astronaut Horizontal Position --
function Astronaut:getHorizontalPosition()
   return self.x
end


-- Set Astronaut Speed --
function Astronaut:setSpeed(speed)
   self.speed = speed
end


-- Upgrade A Movement Skill --
function Astronaut:movementUpgrade(skill)
   self.movement[skill] = self.movement[skill] + 1
end


-- Upgrade A Weapon Skill --
function Astronaut:weaponUpgrade()
   self.weapon[skill] = self.weapon[skill] + 1
end


-- Upgrade A Capture Skill --
function Astronaut:captureUpgrade()
   self.capture[skill] = self.capture[skill] + 1
end


-- Update Function --
function Astronaut:update(dt)
   
   -- move to north --
   if love.keyboard.isDown('w', 'up') then
      if self.y > 0 then
	 self.y = self.y - self.speed*dt
      end
   end
   
   -- move to south --
   if love.keyboard.isDown('s', 'down') then
      if self.y < love.graphics.getHeight() - self.image:getHeight() then
	 self.y = self.y + self.speed*dt
      end
   end
   
   --move to east --
   if love.keyboard.isDown('a', 'left') then
      if self.x > 0 then
	 self.x = self.x - self.speed*dt
      end
   end
   
   --move to west --
   if love.keyboard.isDown('d', 'right') then
      if self.x < love.graphics.getWidth() - self.image:getWidth() then
	 self.x = self.x + self.speed*dt
      end
   end
   
end


-- Draw Function --
function Astronaut:draw()
   love.graphics.draw(self.image, self.x, self.y)
end


return Astronaut
