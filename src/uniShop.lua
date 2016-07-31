gamestate = require "src.gamestate"
local uniShop = {}

function uniShop:enter()
	uniShopImg = love.graphics.newImage("assets/uniShop/balcaoFundo.png")
	cliente1 = love.graphics.newImage("assets/uniShop/cl01.png")
	cliente2 = love.graphics.newImage("assets/uniShop/cl02.png")
	cliente1y = 320
	cliente2y = 343
	self.timer = 0
	if currentMissionNumber == nil then
		currentMissionNumber = 1
		uniShop:assignMission()
	end
end

function uniShop:update(dt)
	self.timer = self.timer + dt
	if self.timer >= 0.2 then
		if cliente1y == 360 then
			cliente1y = 320
			cliente2y = 370
		else
			cliente1y = 360
			cliente2y = 330
		end
		self.timer = 0
	end
	if love.keyboard.isDown("lctrl") then
		gamestate.switch(space)
	end
	if currentMissionComplete == true then end

end

function uniShop:draw()
	love.graphics.draw(uniShopImg, 0, 0)
	love.graphics.setColor(100, 100, 100)
	love.graphics.print("Dia: " .. currentMissionNumber, 528, 60)
	love.graphics.print("Azul: " .. currentMission[0], 528, 75)
	love.graphics.print("Verde: " .. currentMission[1], 528, 90)
	love.graphics.print("Roxo: " .. currentMission[2], 528, 105)
	love.graphics.print("Vermelho: " .. currentMission[3], 528, 120)
	love.graphics.print("Branco: " .. currentMission[4], 528, 135)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(cliente1, 440, cliente1y)
	love.graphics.draw(cliente2, 624, cliente2y)
	if currentMissionComplete == true then
		--Desenha botão de terminar missão
	end

end

function uniShop:leave()

end

function uniShop:assignMission()
	if currentMissionNumber == 1 then
		currentMission[0] = math.random(2,4)
		currentMission[1] = math.random(1,3)
		currentMission[2] = math.random(0,2)
		currentMission[3] = math.random(0,1)
		currentMission[4] = 0
	elseif currentMissionNumber == 2 then
		currentMission[0] = math.random(3,4)
		currentMission[1] = math.random(2,3)
		currentMission[2] = math.random(1,3)
		currentMission[3] = math.random(1,2)
		currentMission[4] = 0
	elseif currentMissionNumber == 3 then
		currentMission[0] = math.random(3,5)
		currentMission[1] = math.random(3,4)
		currentMission[2] = math.random(2,3)
		currentMission[3] = 3
		currentMission[4] = 1
	elseif currentMissionNumber == 4 then
		currentMission[0] = math.random(3,7)
		currentMission[1] = math.random(4,8)
		currentMission[2] = math.random(5,8)
		currentMission[3] = math.random(3,5)
		currentMission[4] = 3
	elseif currentMissionNumber == 5 then
		currentMission[0] = 10
		currentMission[1] = 10
		currentMission[2] = 10
		currentMission[3] = 10
		currentMission[4] = 10
	end
end

return uniShop
