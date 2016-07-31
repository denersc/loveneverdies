gamestate = require "src.gamestate"

local menu = require "src.menu"

currentMission = {}
currentMissionNumber = nil
currentMissionComplete = false
currentMoney = 0
currentPopularity = 0.5

function love.load()
    math.randomseed(os.clock())
    gamestate.registerEvents()
    gamestate.switch(menu)
end
