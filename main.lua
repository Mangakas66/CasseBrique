scene = "game";

local Game = require('game');

-- Chargement des variables
function love.load()
	SCREEN_WIDTH = love.graphics.getWidth();
	SCREEN_HEIGHT = love.graphics.getHeight();
	
	Game.load()
	
	-- score = 0;
	-- canScore = true;
	-- time = 0;
	-- gameOver = false;
end

-- Actualisation du jeu
function love.update(deltaTime)
	Game.update(deltaTime)
	

	
	-- if (ball.x <= 0) then
		-- ball.bdx = ball.speed;
	-- end
	-- if (ball.x >= love.graphics.getWidth() - ball.size) then
		-- ball.bdx = -ball.speed;
	-- end
	-- if (ball.y <= 0) then
		-- ball.bdy = ball.speed;
		-- canScore = true;
	-- end
	-- if (ball.y >= love.graphics.getHeight() - ball.size) then
		-- gameOver = true;
	-- end
	-- if ((ball.x >= player.x and ball.x <= player.x + player.height) and ball.y >= player.y - 12) then
		-- ball.speed = ball.speed + 0.3;
		-- ball.bdy = -ball.speed;
		-- score = score + 1;
		-- canScore = false;
	-- end
		
		-- ball.x = ball.x + ball.bdx;
		-- ball.y = ball.y + ball.bdy;
end

-- Affichage du jeu
function love.draw()
	Game.draw()
end

-- Récupère les inputs du clavier
function love.keypressed(key)
	Game.keypressed(key);
end

-- Récupère les fin d'inputs du clavier
function love.keyreleased(key)
	Game.keyreleased(key);
end