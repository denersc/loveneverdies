local class = require 'src.30log'
local Bullet = class('src.Bullet')

function Bullet:init(x, y, playerX, playerY, speed)
    self.x = x
    self.y = y
    self.m = (y - playerY)/(x - playerX)
    self.speed = speed
    self.img = love.graphics.newImage("assets/bullet.png")
end

function Bullet:test()
    print("teste")
end

function Bullet:move(dt)
    local dist = self.speed*dt
    local arc = math.atan(self.m)

    self.x = self.x + dist*math.cos(arc)
    self.y = self.y + dist*math.sin(arc)
end

function Bullet:draw()
    love.graphics.draw(self.img, self.x, self.y)
end


return Bullet
