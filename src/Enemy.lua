local class = require 'src.30log'
local Enemy = class('Enemy')
local Bullet = require 'src.Bullet'

function Enemy:init(x, y)
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
    love.graphics.draw(self.img, self.x, self.y)
    for i, bullet in ipairs(self.bullets) do
        bullet:draw()
    end
end

function Enemy:distancePlayerEnemy(playerX, playerY)

    local dX = self.x - playerX
    local dY = self.y - playerY

    local distance = math.sqrt( ( dX^2 ) + ( dY^2 ) )
    return distance
end

function Enemy:move(dt, playerX, playerY)
    --enemy only moves if she is between the range
    local maxDist = 400
    local minDist = 150

    if maxDist > self:distancePlayerEnemy(playerX, playerY) and
       minDist < self:distancePlayerEnemy(playerX, playerY) then
        if playerX > self.x then
            self.x = self.x + self.speed
        else
            self.x = self.x - self.speed
        end

        if playerY > self.y then
            self.y = self.y + self.speed
        else
            self.y = self.y - self.speed
        end
    end
end

function Enemy:shoot(playerX, playerY)
    local m = (self.y - playerY)/(self.x - playerX)
    if playerX > self.x then
        local bullet = Bullet(self.x, self.y, playerX, playerY, 300)
        table.insert(self.bullets, bullet)
    else
        local bullet = Bullet(self.x, self.y, playerX, playerY, -300)
        table.insert(self.bullets, bullet)
    end

    if table.getn(self.bullets) > 5 then
        table.remove(self.bullets, 1)
    end
end

function Enemy:update(dt, playerX, playerY)
    self:move(dt, playerX, playerY)
    self.cooldown = self.cooldown + dt
    --self.cooldown = 2
    if self.cooldown >= 0.5 then
        self:shoot(playerX, playerY)
        self.cooldown = 0
    end
    for i, bullet in ipairs(self.bullets) do
        bullet:move(dt)
    end
end

return Enemy
