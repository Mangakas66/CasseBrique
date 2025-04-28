-- Fichier s'occuppant de la gestion d'une partie
-- Il est aussi le controlleur générale du jeu pour des raisons de simplicités
local Menu = require('menu')
local GameValues = require('gameValues')
local Racket = require('racket')
local Ball = require('ball')
local Brick = require('brick')
local Grid = require('grid')
local ControllerCollision = require('controllerCollision')

local game = {}
game.start = false

local ball = Ball:new({})
local actualGrid = Grid:new({brick = Brick, actual = {}})
local cc = ControllerCollision:new({racket = Racket, ball = ball, grid = actualGrid})

function resetGame()
	game.start = false
	resetRacket()
	resetBall()
	actualGrid:reset()
	actualGrid:setLvl1()
end

function resetRacket()
	Racket.x = SCREEN_WIDTH/2
	Racket.y = SCREEN_HEIGHT - 20
end

function resetBall()
	ball.x = SCREEN_WIDTH/2
	ball.y = SCREEN_HEIGHT - Racket.height - ball.size
	ball.isMooving = false
end

function game.load()
	resetGame()
	cursor = {}
	cursor.hand = love.mouse.getSystemCursor("hand")
	cursor.arrow = love.mouse.getSystemCursor("arrow")
end

function game.update(deltaTime)
	-- Position de la souris
	local mouseX = love.mouse.getX()
	local mouseY = love.mouse.getY()
	
	-- Si on est dans la scene 'menu'
	if (GameValues.scene == 'menu') then
		if (mouseY >= Menu.option[1].y and mouseY <= Menu.option[1].y + 40 and mouseX >= SCREEN_WIDTH/2 - 75 and mouseX <= SCREEN_WIDTH/2 + 75) then
			Menu.option[1].underlineColor = Menu.hoverColor
			love.mouse.setCursor(cursor.hand)
		elseif (mouseY >= Menu.option[2].y and mouseY <= Menu.option[2].y + 40 and mouseX >= SCREEN_WIDTH/2 - 85 and mouseX <= SCREEN_WIDTH/2 + 85) then
			Menu.option[2].underlineColor = Menu.hoverColor
			love.mouse.setCursor(cursor.hand)
		elseif (mouseY >= Menu.option[3].y and mouseY <= Menu.option[3].y + 40 and mouseX >= SCREEN_WIDTH/2 - 95 and mouseX <= SCREEN_WIDTH/2 + 95) then
			Menu.option[3].underlineColor = Menu.hoverColor
			love.mouse.setCursor(cursor.hand)
		else
			for i= 1, #Menu.option do
				Menu.option[i].underlineColor = Menu.initialColor
			end
			love.mouse.setCursor(cursor.arrow)
		end
	end
	
	-- Si on est dans la scene 'game' et que le jeu a commencé
	if (game.start == true and GameValues.scene == 'game') then
		GameValues.score = GameValues.score + 1
		Racket.moove(deltaTime)
		if (ball.isMooving == true) then
			ball:moove(deltaTime)
			cc:ballCollision()
			GameValues.score = actualGrid.initialNumberBrick - actualGrid.actualNumberBrick
			if (GameValues.score == actualGrid.initialNumberBrick) then
				resetGame()
			end
		end
		if (ball.y - ball.size > SCREEN_HEIGHT) then
			resetGame()
		end
	end
end

function game.draw()
	-- Couleurs blanche par défaut
	love.graphics.setColor(1, 1, 1)
	
	if (GameValues.scene == 'menu') then
		-- Title
		love.graphics.printf(Menu.title.text, GameValues.fonts.title, 0, Menu.title.y, SCREEN_WIDTH, 'center')
		
		for i = 1, #Menu.option do
			-- Options
			love.graphics.printf(Menu.option[i].text, GameValues.fonts.option, 0, Menu.option[i].y, SCREEN_WIDTH, 'center')
			
			-- Underlines color
			love.graphics.setColor(Menu.option[i].underlineColor)
			
			-- Underlines
			love.graphics.rectangle('fill', SCREEN_WIDTH/2 - Menu.option.underlineWidth/2, Menu.option[i].y + 45, Menu.option.underlineWidth, 2, 2)
			
			-- Couleur blanche a nouveau pour la prochaine option
			love.graphics.setColor(1, 1, 1)
		end
		-- Efface le jeu en fond
		love.graphics.setColor(.2, .2, .2)
	end
	
	-- Score
	love.graphics.printf(GameValues.score, GameValues.fonts.score, -10, 0, SCREEN_WIDTH, 'right')
	
	-- Raquette du joueur
	love.graphics.rectangle('fill', Racket.x - Racket.width/2, Racket.y - Racket.height/2, Racket.width, Racket.height, 20)
	
	-- Balle
	love.graphics.rectangle('fill', ball.x - ball.size/2, ball.y - ball.size/2, ball.size, ball.size, 20)
	
	-- Brick
	if (GameValues.scene == 'game') then
		for i = 1, 20 do
			for j = 1, 36 do
				if (actualGrid.property.actual[i][j] == true) then
					love.graphics.setColor(i/20, 0, j/32)
					love.graphics.rectangle('fill', j*Brick.width - Brick.width, i*Brick.height - Brick.height, Brick.width -1, Brick.height - 1, 5)
				end
			end
		end
	end
end

function game.keypressed(key)
	if (key == 'q' or key == 'd') then
		Racket.keypressed(key)
	end
end

function game.keyreleased(key)
	if (GameValues.scene == 'game' and ball.isMooving == false and key == 'space') then
		ball:start()
		game.start = true
	end
	if (key == 'q' or key == 'd') then
		Racket.keyreleased(key)
	end
end

function love.mousepressed(mouseX, mouseY, button)
	if (GameValues.scene == 'menu' and button == 1) then
		if (mouseY >= Menu.option[1].y and mouseY <= Menu.option[1].y + 40 and mouseX >= SCREEN_WIDTH/2 - 75 and mouseX <= SCREEN_WIDTH/2 + 75) then
			GameValues.scene = 'game'
			love.mouse.setCursor(cursor.arrow)
			-- elseif (mouseY >= Menu.option[2].y and mouseY <= Menu.option[2].y + 40 and mouseX >= SCREEN_WIDTH/2 - 85 and mouseX <= SCREEN_WIDTH/2 + 85) then
			-- TODO faire menu option
		elseif (mouseY >= Menu.option[3].y and mouseY <= Menu.option[3].y + 40 and mouseX >= SCREEN_WIDTH/2 - 95 and mouseX <= SCREEN_WIDTH/2 + 95) then
			love.event.quit()
		end
	end
end

return game