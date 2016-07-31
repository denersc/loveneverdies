local class = require 'src.30log'
local Enemy = class('Enemy')
local Bullet = require 'src.Bullet'

function Enemy:init(x, y)
    realX = 0
    realY = 0
    self.x = x
    self.y = y
    self.speed = 3
    self:setSprite("assets/enemy.png")
    self.bullets = {}
    self.cooldown = 0
end

function Enemy:setSprite(path)
    self.img = love.graphics.newImage(path)
end

function Enemy:draw()
    realX = self.x + backgroundx
    realY = self.y + backgroundy
    love.graphics.draw(self.img, realX, realY)
    for i, bullet in ipairs(self.bullets) do
        bullet:draw()
    end
end

function Enemy:distancePlayerEnemy(playerX, playerY)

    local dX = realX - playerX
    local dY = realY - playerY

    local distance = math.sqrt( ( dX^2 ) + ( dY^2 ) )
    return distance
end

function Enemy:move(dt, playerX, playerY)
    --enemy only moves if she is between the range
    local maxDist = 400
    local minDist = 150

    if maxDist > self:distancePlayerEnemy(playerX, playerY) and
       minDist < self:distancePlayerEnemy(playerX, playerY) then
        if playerX > realX then
            realX = realX + self.speed
        else
            realX = realX - self.speed
        end

        if playerY > realY then
            realY = realY + self.speed
        else
            realY = realY - self.speed
        end
    end
end

function Enemy:shoot(playerX, playerY)
    if 500 > self:distancePlayerEnemy(playerX, playerY) then
        local m = (realY - playerY)/(realX - playerX)
        if playerX > realX then
            local bullet = Bullet(realX, realY, playerX, playerY, 300)
            table.insert(self.bullets, bullet)
        else
            local bullet = Bullet(realX, realY, playerX, playerY, -300)
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
    if self.cooldown >= 0.5 then
        self:shoot(playerX, playerY)
        self.cooldown = 0
    end
    for i, bullet in ipairs(self.bullets) do
        bullet:move(dt)
    end
end

return Enemy
