gamestate = require "src.gamestate"

space = require "src.space"
uniShop = require "src.uniShop"
game = require "src.game"
local menu = require "src.menu"
local intro = require "src.intro"

currentMission = {}
currentMissionNumber = nil
currentMissionComplete = false
currentMoney = 0
currentPopularity = 0.5

function love.load()    
    math.randomseed(os.clock())
    gamestate.registerEvents()
    --gamestate.switch(intro)
    gamestate.switch(menu)
end
