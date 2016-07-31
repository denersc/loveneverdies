local class = require 'src.30log'
local Enemy = class('Enemy')
local Bullet = require 'src.Bullet'

function Enemy:init(x, y)
    self.realX = 0
    self.realY = 0
    self.x = x
    self.y = y
    self.speed = 200
    self:setSprite("assets/enemy.png")
    self.bullets = {}
    self.cooldown = 0
end

function Enemy:setSprite(path)
    self.img = love.graphics.newImage(path)
end

function Enemy:draw()
    self.realX = self.x + backgroundx
    self.realY = self.y + backgroundy
    love.graphics.draw(self.img, self.realX, self.realY)
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

    if maxDist > self:distancePlayerEnemy(playerX, playerY) and
       minDist < self:distancePlayerEnemy(playerX, playerY) then
        if playerX > self.realX then
            self.x = self.x + self.speed*dt
        else
            self.x = self.x - self.speed*dt
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
end

return Enemy
