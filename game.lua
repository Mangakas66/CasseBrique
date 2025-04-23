-- Fichier s'occuppant de la gestion d'une partie
-- Il est aussi le controlleur générale du jeu pour des raisons de simplicités
local Racket = require('racket')
local Ball = require('ball')
local ControllerCollision = require('ControllerCollision')

local game = {}
game.start = true

local cc = ControllerCollision:new({racket = Racket, ball = Ball})

function resetGame()
	resetRacket()
	resetBall()
end

function resetRacket()
	Racket.x = SCREEN_WIDTH/2
	Racket.y = SCREEN_HEIGHT - 20
end

function resetBall()
	Ball.x = SCREEN_WIDTH/2
	Ball.y = SCREEN_HEIGHT - Racket.height - Ball.size
	Ball.isMooving = false
end

function game.load()
	resetGame()
end

function game.update(deltaTime)
	-- Si on est dans la scene "game" et que le jeu a commencé
	if (game.start == true and scene == "game") then
		Racket.moove(deltaTime)
		if (Ball.isMooving == true) then
			Ball.moove(deltaTime)
			cc:ballCollision()
		end
	end
end

function game.draw()
	love.graphics.setColor(255, 255, 255)
	-- Raquette du joueur
	love.graphics.rectangle("fill", Racket.x - Racket.width/2, Racket.y - Racket.height/2, Racket.width, Racket.height, 20)
	-- Balle
	love.graphics.rectangle("fill", Ball.x - Ball.size/2, Ball.y - Ball.size/2, Ball.size, Ball.size, 20)
	-- Ligne décorative (à supprimer éventuellement)
	love.graphics.line(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2)

end

function game.keypressed(key)
	if (key == "q" or key == "d") then
		Racket.keypressed(key)
	end
end

function game.keyreleased(key)
	if (scene == "game" and key == "space") then
		Ball.start()
	end
	if (key == "q" or key == "d") then
		Racket.keyreleased(key)
	end
end

return game