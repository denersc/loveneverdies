gamestate = require "src.gamestate"
local game = require "src.game"
local space = {}

function space:enter()
	spaceImg = love.graphics.newImage("assets/space.png")
	ship = {x=0, y=0, speed=500, img=love.graphics.newImage("assets/ship.png")}
end

function space:update(dt)
	if love.keyboard.isDown('w', 'up') and ship.y > 0 then
		ship.y = ship.y - dt*ship.speed
	end
	if love.keyboard.isDown('s', 'down') and ship.y < love.graphics.getHeight() - ship.img:getHeight() then
		ship.y = ship.y + dt*ship.speed
	end
	if love.keyboard.isDown('a', 'left') and ship.x > 0 then
		ship.x = ship.x - dt*ship.speed
	end
	if love.keyboard.isDown('d', 'right') and ship.x < love.graphics.getWidth() - ship.img:getWidth() then
		ship.x = ship.x + dt*ship.speed
	end
	
	if love.keyboard.isDown('lctrl') then
		print(ship.x .. "and" .. ship.y)
	end
	
	--POUSO DO VOO
	if ship.x > 18 and ship.x < 176 and ship.y > 108 and ship.y < 294 then
		love.graphics.print("Aperte espaço para pousar", 200, 200)
		if love.keyboard.isDown('space') then
			print("pouso terra")
		end
	elseif ship.x > 465 and ship.x < 624 and ship.y > 228 and ship.y < 462 then
		if love.keyboard.isDown('space') then
			gamestate.switch(game)
		end
	elseif ship.x > 415 and ship.x < 515 and ship.y > 28 and ship.y < 135 then
		if love.keyboard.isDown('space') then
			print("pouso shop")
		end
	end
	
end

function space:draw()
	love.graphics.draw(spaceImg,0,0)
	love.graphics.draw(ship.img,ship.x,ship.y)
	
	if ship.x > 18 and ship.x < 176 and ship.y > 108 and ship.y < 294 then
		love.graphics.print({{255,0,0},"Aperte espaço para pousar"}, love.graphics.getWidth()/2-90, 500, 0, 1.2)
	elseif ship.x > 465 and ship.x < 624 and ship.y > 228 and ship.y < 462 then
		love.graphics.print({{255,0,0},"Aperte espaço para pousar"}, love.graphics.getWidth()/2-90, 500, 0, 1.2)
	elseif ship.x > 415 and ship.x < 515 and ship.y > 28 and ship.y < 135 then
		love.graphics.print({{255,0,0},"Aperte espaço para pousar"}, love.graphics.getWidth()/2-90, 500, 0, 1.2)
	end

end

function space:leave()
end

return space
