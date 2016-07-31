local intro = {}
local time = 0
local imagens = {}
local ii= 1
local num = 174

local menu = require "src.menu"

function intro:update(dt)
    time = time + dt
    if time >= 0.04
        then
            ii= ii+ 1
            time = 0
        end
    if ii>= num
        then
            gamestate.switch(menu)
        end
    if ii== 54
        then
            love.audio.play(sound_rcg)
        end
    if love.keyboard.isDown("return")
        then
            love.audio.stop(sound_rcg)
            gamestate.switch(menu)
        end
end

function intro:enter()
    sound_rcg = love.audio.newSource("assets/rcg.ogg", "static")

    for i=1,num,1
    do
        table.insert(imagens, #imagens+1,
                     love.graphics.newImage("assets/intro/intro_" .. i.. ".png"))
    end
end

function intro:draw()
    love.graphics.draw(imagens[ii], 16, 12)
end

return intro
