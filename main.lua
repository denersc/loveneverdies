gamestate = require "src.gamestate"

menu = require "src.menu"
space = require "src.space"
uniShop = require "src.uniShop"
game = require "src.game"

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
