local class = require 'src.30log'
local Bullet = class('src.Bullet')

function Bullet:checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
   return x1 < x2+w2 and
      x2 < x1+w1 and
      y1 < y2+h2 and
      y2 < y1+h1
end


function Bullet:init(x, y, playerX, playerY, speed)
    self.x = x
    self.y = y
    self.m = (y - playerY)/(x - playerX)
    self.speed = speed
    if speed > 0 then
        self.img = love.graphics.newImage("assets/bulletR.png")
    else
        self.img = love.graphics.newImage("assets/bulletL.png")
    end
end

function Bullet:test()
    print("teste")
end

function Bullet:move(dt)
    local dist = self.speed*dt
    local arc = math.atan(self.m)

    self.x = self.x + dist*math.cos(arc)
    self.y = self.y + dist*math.sin(arc)

    collision = self:checkCollision (self.x, self.y,
				self.img:getWidth(), self.img:getHeight(),
				astronaut:getHorizontalPosition(),
				astronaut:getVerticalPosition(),
				astronaut:getImage():getWidth(),
				astronaut:getImage():getHeight())
    
    return (collision)
end

function Bullet:draw()
    love.graphics.draw(self.img, self.x, self.y)
end


return Bullet
