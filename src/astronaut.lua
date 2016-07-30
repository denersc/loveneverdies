local class = require 'src.30log'
local astronaut = class("astronaut")

-- Astronaut Constructor --
function astronaut:init(speed, x, y, imagePath)

   --movement
   self.speed = speed
   self.x = x
   self.y = y

   --image
   self.image = love.graphics.newImage(imagePath)
   
end


-- Set Astronaut Image --
function astronaut:setImage(imagePath)
   self.image = love.graphics.newImage(imagePath)   
end


-- Get Astronaut Image --
function astronaut:getImage()
   return self.image
end


-- Set Astronaut Position --
function astronaut:setPosition(x, y)
   self.x = x
   self.y = y   
end


-- Get Astronaut Position --
function astronaut:getPosition()
   return self.x, self.y
end


-- Set Astronaut Speed --
function astronaut:setSpeed(speed)
   self.speed = speed
end


-- Upgrade A Movement Skill --
function astronaut:movementUpgrade(skill)
   self.movement[skill] = self.movement[skill] + 1
end


-- Upgrade A Weapon Skill --
function astronaut:weaponUpgrade()
   self.weapon[skill] = self.weapon[skill] + 1
end


-- Upgrade A Capture Skill --
function astronaut:captureUpgrade()
   self.capture[skill] = self.capture[skill] + 1
end


-- Update Function --
function astronaut:update(dt)
   
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
function astronaut:draw()
   love.graphics.draw(self.image, self.x, self.y)
end


return astronaut
