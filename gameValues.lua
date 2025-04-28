-- Fichier contenant toutes les valeurs a conserver.
local GameValues = {}
SCREEN_WIDTH = love.graphics.getWidth()
SCREEN_HEIGHT = love.graphics.getHeight()

GameValues.scene = 'menu'

GameValues.fonts = {}
GameValues.fonts.path = 'assets/fonts/SuperchargeStraight-nR87V.otf'
GameValues.fonts.score = love.graphics.newFont(GameValues.fonts.path, 60)
GameValues.fonts.title = love.graphics.newFont(GameValues.fonts.path, 80)
GameValues.fonts.option = love.graphics.newFont(GameValues.fonts.path, 40)

GameValues.score = 0

return GameValues