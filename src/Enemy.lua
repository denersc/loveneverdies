local class = require 'src.30log'
local Enemy = class('Enemy')

function Enemy:init(x, y)
    self.x = x
    self.y = y
    self.speed = 3
    self:setSprite("assets/enemy.png")
end

function Enemy:setSprite(path)
    self.img = love.graphics.newImage(path)
end

function Enemy:draw()
    love.graphics.draw(self.img, self.x, self.y)
end

function Enemy:distancePlayerEnemy(playerX, playerY)

    local dX = self.x - playerX
    local dY = self.y - playerY

    local distance = math.sqrt( ( dX^2 ) + ( dY^2 ) )
    return distance
end

function Enemy:update(dt, playerX, playerY)
    --enemy only moves if she is between the range
    local maxDist = 300
    local minDist = 100

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

return Enemy
