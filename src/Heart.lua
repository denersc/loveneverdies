local class = require 'src.30log'
local Heart = class('src.Heart')


function Heart:init(x, y)
   self.x = x
   self.y = y
   self.image = love.graphics.newImage("assets/heart.png")
end


function Heart:getImage()
   return self.image
end


function Heart:getHorizontalPosition()
   return self.x
end


function Heart:getVerticalPosition()
   return self.y
end


return Heart
