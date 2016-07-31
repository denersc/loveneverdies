local class = require 'src.30log'
local Enemy = class('Enemy')
local Bullet = require 'src.Bullet'

function Enemy:init(x, y)
    self.realX = 0
    self.realY = 0
    self.x = x
    self.y = y
    self.speed = 200
    self.bullets = {}
    self.cooldown = 0
    
    --Animation Variables
    self.img = {}
	self.isWalking = false
	self.orientation = 1 -- Quando em -1 espelha a sprite
	self.currentImgIndex = 1
	self.animTimer = 0
	self.animTimerMax = 0.08
    self:setSprite("assets/llama/")
end

function Enemy:setSprite(path)
	self.img[0] = love.graphics.newImage(path.. "idle.png")
	for i=1,8 do
		self.img[i] = love.graphics.newImage(path .. "andando/".. i .. ".png")
    end
end

function Enemy:draw()
    self.realX = self.x + backgroundx
    self.realY = self.y + backgroundy
 	local xOffset = self.img[self.currentImgIndex]:getWidth()/2
	local yOffset = self.img[self.currentImgIndex]:getHeight()/2
	
    if self.isWalking == false then love.graphics.draw(self.img[0], self.realX, self.realY, 0, self.orientation, 1, xOffset, yOffset)
    else love.graphics.draw(self.img[self.currentImgIndex], self.realX, self.realY, 0, self.orientation, 1, xOffset, yOffset) end
    for i, bullet in ipairs(self.bullets) do
        bullet:draw()
    end
end

function Enemy:distancePlayerEnemy(playerX, playerY)

    local dX = self.realX - playerX
    local dY = self.realY - playerY

    local distance = math.sqrt( ( dX^2 ) + ( dY^2 ) )
    return distance
end

function Enemy:move(dt, playerX, playerY)
    --enemy only moves if she is between the range
    local maxDist = 400
    local minDist = 150
    
    self.isWalking = false

    if maxDist > self:distancePlayerEnemy(playerX, playerY) and
       minDist < self:distancePlayerEnemy(playerX, playerY) then
       self.isWalking = true
        if playerX > self.realX then
            self.x = self.x + self.speed*dt
            self.orientation = 1
        else
            self.x = self.x - self.speed*dt
            self.orientation = -1
        end

        if playerY > self.realY then
            self.y = self.y + self.speed*dt
        else
            self.y = self.y - self.speed*dt
        end
    end
end

function Enemy:shoot(playerX, playerY)
    if 500 > self:distancePlayerEnemy(playerX, playerY) then
        local m = (self.realY - playerY)/(self.realX - playerX)
        if playerX > self.realX then
            local bullet = Bullet(self.realX, self.realY, playerX, playerY, 300)
            table.insert(self.bullets, bullet)
        else
            local bullet = Bullet(self.realX, self.realY, playerX, playerY, -300)
            table.insert(self.bullets, bullet)
        end

        if table.getn(self.bullets) > 5 then
            table.remove(self.bullets, 1)
        end
    end
end

function Enemy:update(dt, playerX, playerY)
    self:move(dt, playerX, playerY)
    self.cooldown = self.cooldown + dt

    if self.cooldown >= 1 then
        self:shoot(playerX, playerY)
        self.cooldown = 0
    end
    for i, bullet in ipairs(self.bullets) do
       collision = bullet:move(dt)
       if collision then
	  table.remove(self.bullets, i)
	  astronaut:setLife(astronaut:getLife() - 1)
	  hud:removeHeart()
       end
    end
    
    --Animação da llama
	if self.isWalking == true then
		self.animTimer = self.animTimer + dt
		if self.animTimer > self.animTimerMax then
			self.animTimer = 0
			self.currentImgIndex = self.currentImgIndex+1
			if self.currentImgIndex > 8 then self.currentImgIndex = 1 end
		end
	end
	
end

return Enemy
