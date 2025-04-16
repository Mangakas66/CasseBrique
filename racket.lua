local racket = {};

-- Valeurs de la raquette
racket.x = 0;
racket.y = 0;
racket.width = 170;
racket.height = 20;
racket.speed = 200;

local leftIsPressed = false;
local rightIsPressed = false;
local goingLeft = false;
local goingRight = false;

-- Déplacement de la raquette
function racket.moove(deltaTime)
	if (goingLeft == true) then
		mooveToTheLeft(deltaTime);
	end
	if (goingRight == true) then
		mooveToTheRight(deltaTime);
	end
end

-- Déplacement de la raquette sur la gauche
function mooveToTheLeft(deltaTime)
	racket.x = racket.x - racket.speed*deltaTime;
end

-- Déplacement de la raquette sur la droite
function mooveToTheRight(deltaTime)
	racket.x = racket.x + racket.speed*deltaTime;
end

-- Choix du sens de direction de la raquette en fonction de quelles touches sont pressées
function whereToGo(direction, action)
	if (direction == "q" and action == "pressed") then
		goingLeft = true;
		goingRight = false;
	end
	
	if (direction == "q" and action == "released") then
		goingLeft = false;
		if (rightIsPressed == true) then
			goingRight = true;
		end
	end
	
	if (direction == "d" and action == "pressed") then
		goingRight = true;
		goingLeft = false;
	end
	
	if (direction == "d" and action == "released") then
		goingRight = false;
		if (leftIsPressed == true) then
			goingLeft = true;
		end
	end
end

-- Récupération des inputs pour la raquette
function racket.keypressed(key)
	if (key == "q") then
		leftIsPressed = true;
	end
	if (key == "d") then
		rightIsPressed = true;
	end
	whereToGo(key, "pressed");
end

-- Récupération des fin d'inputs pour la raquette
function racket.keyreleased(key)
	if (key == "q") then
		leftIsPressed = false;
	end
	if (key == "d") then
		rightIsPressed = false;
	end
	whereToGo(key, "released");
end

return racket;