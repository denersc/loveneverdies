local class = require 'src.30log'
local Unicorn = class('Unicorn')

function Unicorn:init(x, y, uniColor)
	self.x = x
	self.y = y
	self.canWalk = true
	self.isWalking = false
	self.idleTime = false
	self.speed = 0
	self.direction = 0
	self.distanceCounter = 0
	self.distanceFinal = 0
	--Animation Variables
	self.orientation = 1 -- Quando em -1 espelha a sprite
	self.currentImgIndex = 1
	self.animTimer = 0
	self.animTimerMax = 0.08
	
	if uniColor == 0 then
		self.sightDistance = 500
		self.baseSpeed = 100
		self:setSprite("assets/unicorns/white/")
	elseif uniColor == 1 then
		self.sightDistance = 500
		self.baseSpeed = 100
		self:setSprite("assets/unicorns/blue/")
	elseif uniColor == 2 then
		self.sightDistance = 500
		self.baseSpeed = 100
		self:setSprite("assets/unicorns/green/")
	elseif uniColor == 3 then
		self.sightDistance = 500
		self.baseSpeed = 100
		self:setSprite("assets/unicorns/red/")
	elseif uniColor == 4 then
		self.sightDistance = 500
		self.baseSpeed = 100
		self:setSprite("assets/unicorns/purple/")
	end
end

function Unicorn:setSprite(path)
	self.img = {}
	for i=1, 6 do
		self.img[i] = love.graphics.newImage(path .. i .. ".png")
	end 
end

function Unicorn:draw(backgroundX, backgroundY)
	local xOffset = self.img[self.currentImgIndex]:getWidth()/2
	local yOffset = self.img[self.currentImgIndex]:getHeight()/2
	love.graphics.draw(self.img[self.currentImgIndex], self.x+backgroundX, self.y+backgroundY, 0, 0.15*self.orientation, 0.15, xOffset, yOffset)
end

function Unicorn:update(dt, playerX, playerY)
	self:move(dt)
	self:checkPredator(playerX, playerY)
	
	--Animação do unicornio
	if self.idleTime == false then
		self.animTimer = self.animTimer + dt
		if self.animTimer > self.animTimerMax then
			self.animTimer = 0
			self.currentImgIndex = self.currentImgIndex+1
			if self.currentImgIndex > 5 then self.currentImgIndex = 1 end
		end
	end
		
end

--MOVIMENTA O UNICORNIO--
function Unicorn:move(dt)
	if self.canWalk == false then return end
	if self.isWalking == false then
		self.idleTime = not self.idleTime
		if self.idleTime == false then 
			self.direction = math.random(0,3) 
			if self.direction == 0 then self.orientation = 1
			elseif self.direction == 2 then self.orientation = -1
			end
		end
		self.distanceFinal = math.random(100, 200)
		self.speed = math.random(self.baseSpeed, self.baseSpeed+50)
		self.distanceCounter = 0
		self.isWalking = true
	else
		if self.idleTime == false then
			if self.direction == 0 and self.x < love.graphics.getWidth() then 
				self.x = self.x + dt*self.speed
			elseif self.direction == 1 and self.y < love.graphics.getHeight() then
				self.y = self.y + dt*self.speed
			elseif self.direction == 2 and self.x > 0 then
				self.x = self.x - dt*self.speed
			elseif self.direction == 3 and self.y > 0 then
				self.y = self.y - dt*self.speed
			end
		end
		self.distanceCounter = self.distanceCounter + dt*self.speed
		if self.distanceCounter > self.distanceFinal then
			self.distanceCounter = 0
			self.isWalking = false
		end
	end
end

--VERIFICA SE O PLAYER ESTA NA LINHA DE VISÃO DO UNICORNIO --
function Unicorn:checkPredator(playerX, playerY)
	if self.direction == 0 and math.abs(self.y-playerY) < 60 and playerX-self.x > 0 and playerX-self.x < self.sightDistance then
		--Encontrou o player no leste
		self.direction = 2
		self.orientation = -1
		self.distanceFinal = 150
		self.speed = 150
		self.distanceCounter = 0
		self.isWalking = true
		self.idleTime = false
	elseif self.direction == 1 and math.abs(self.x-playerX) < 60 and playerY-self.y > 0 and playerY-self.y < self.sightDistance then
		--Encontrou o player no sul
		self.direction = 3
		self.distanceFinal = 150
		self.speed = 150
		self.distanceCounter = 0
		self.isWalking = true
		self.idleTime = false
	elseif self.direction == 2 and math.abs(self.y-playerY) < 60 and playerX-self.x < 0 and self.x-playerX < self.sightDistance then
		--Encontrou o player no oeste
		self.direction = 0
		self.orientation = 1
		self.distanceFinal = 150
		self.speed = 150
		self.distanceCounter = 0
		self.isWalking = true
		self.idleTime = false
	elseif self.direction == 3 and math.abs(self.x-playerX) < 60 and playerY-self.y < 0 and self.y-playerY < self.sightDistance then
		--Encontrou o player no norte
		self.direction = 1
		self.distanceFinal = 150
		self.speed = 150
		self.distanceCounter = 0
		self.isWalking = true
		self.idleTime = false
	end
end

function Unicorn:distancePlayerUnicorn(playerX, playerY)
    local dX = self.x - playerX
    local dY = self.y - playerY
    local distance = math.sqrt( ( dX^2 ) + ( dY^2 ) )
    return distance
end

return Unicorn
