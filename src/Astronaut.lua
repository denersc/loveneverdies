local class = require 'src.30log'
local Astronaut = class("Astronaut")

-- Astronaut Constructor --
function Astronaut:init(speed, x, y)

   --movement
   self.speed = speed
   self.x = x
   self.y = y
   
   --unicorn shit
   self.isCarryingUnicorn = false
   
   --animation variables
   	self.isWalking = false
	self.animTimer = 0
	self.animTimerMax = 0.08
	self.orientation = 1 -- Quando em -1 espelha a sprite
	self.currentImgIndex = 0
	--image
    self:setImage("assets/astronaut/")

end


-- Set Astronaut Image --
function Astronaut:setImage(imagePath)
	self.image = {}
	self.image[0] = love.graphics.newImage(imagePath .. "idle.png")
	for i=1, 9 do
		self.image[i] = love.graphics.newImage(imagePath .. i .. ".png")
	end
end


-- Get Astronaut Image --
function Astronaut:getImage()
   return self.image[0]
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
	
	self.isWalking = false

   -- move to north --
   if love.keyboard.isDown('w', 'up') then
	  self.isWalking = true
      if (self.y > 0 and backgroundy >= 0) or (backgroundy <= love.graphics.getHeight() - background:getHeight() and
              self.y >= love.graphics.getHeight() * 0.5) then
          self.y = self.y - self.speed*dt
      elseif backgroundy < 0 then
            backgroundy = backgroundy + self.speed*dt
      end
   end

   -- move to south --
   if love.keyboard.isDown('s', 'down') then
	  self.isWalking = true
      if (self.y < love.graphics.getHeight() - self.image[self.currentImgIndex]:getHeight() and backgroundy <= love.graphics.getHeight() - background:getHeight())
      or (backgroundy >= 0 and self.y <= love.graphics.getHeight() * 0.5) then
	      self.y = self.y + self.speed*dt
      elseif backgroundy >= love.graphics.getHeight() - background:getHeight() then
          backgroundy = backgroundy - self.speed*dt
      end
   end

   --move to west --
   if love.keyboard.isDown('a', 'left') then
      self.isWalking = true
      self.orientation = -1
      if (self.x >= 0 and backgroundx >= 0) or (backgroundx <= -(background:getWidth() - love.graphics.getWidth()) and self.x >= love.graphics.getWidth() * 0.5)
      then
	      self.x = self.x - self.speed*dt
      elseif backgroundx <= 0 then
          backgroundx = backgroundx + self.speed*dt
      end
   end

   --move to east --
   if love.keyboard.isDown('d', 'right') then
      self.isWalking = true
      self.orientation = 1
      if (self.x < love.graphics.getWidth() - self.image[self.currentImgIndex]:getWidth() and backgroundx <= -(background:getWidth() - love.graphics.getWidth()))
      or (backgroundx >= 0 and self.x <= love.graphics.getWidth() * 0.5) then
	      self.x = self.x + self.speed*dt
      elseif backgroundx >= -(background:getWidth() - love.graphics.getWidth()) then
          backgroundx = backgroundx - self.speed*dt
      end
   end
   
   
   
    --Animação do astronauta
	if self.isWalking == true then
		self.animTimer = self.animTimer + dt
		if self.animTimer > self.animTimerMax then
			self.animTimer = 0
			self.currentImgIndex = self.currentImgIndex+1
			if self.currentImgIndex > 9 then self.currentImgIndex = 1 end
		end
	else
		self.currentImgIndex = 0
	end

end


-- Draw Function --
function Astronaut:draw()
	local xOffset = self.image[self.currentImgIndex]:getWidth()/2
	local yOffset = self.image[self.currentImgIndex]:getHeight()/2
   love.graphics.draw(self.image[self.currentImgIndex], self.x, self.y, 0, 0.20*self.orientation, 0.20, xOffset, yOffset)
end


return Astronaut
