local game = {}
game.start = true;

local Racket = require('racket');
-- racket = {};
-- racket.x = 0;
-- racket.y = 0;
-- racket.width = 170;
-- racket.height = 20;
-- racket.speed = 200;

ball = {};
ball.size = 20;
ball.x = 0;
ball.y = 0;
ball.velocityX = 0;
ball.velocityY = 1;
ball.moove = false;

function resetGame()
	resetRacket();
	resetBall();
end

function resetRacket()
	Racket.x = SCREEN_WIDTH/2;
	Racket.y = SCREEN_HEIGHT - 20;
end

function resetBall()
	ball.x = SCREEN_WIDTH/2;
	ball.y = SCREEN_HEIGHT - Racket.height - ball.size;
	ball.moove = false;
end

function game.load()
	resetGame();
end

function game.update(deltaTime)
	-- Si on est dans la scene "game" et que le jeu a commencé
	if (game.start == true and scene == "game") then
		Racket.moove(deltaTime)
	end
end

function game.draw()
	love.graphics.setColor(255, 255, 255);
	-- Raquette du joueur
	love.graphics.rectangle("fill", Racket.x - Racket.width/2, Racket.y - Racket.height/2, Racket.width, Racket.height, 20);
	-- Balle
	love.graphics.rectangle("fill", ball.x - ball.size/2, ball.y - ball.size/2, ball.size, ball.size, 20);
	-- Ligne
	love.graphics.line(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2);

end

function game.keypressed(key)
	if (key == "q" or key == "d") then
		Racket.keypressed(key);
	end
end

function game.keyreleased(key)
	if (key == "q" or key == "d") then
		Racket.keyreleased(key);
	end
end

return game