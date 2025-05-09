-- Fichier représentant une raquette
-- Pour l'instant il n'y a qu'une seule raquette, celle du joueur

local racket = {}

-- Valeurs de la raquette
racket.x = 0
racket.y = 0
racket.width = 170
racket.height = 20
racket.speed = 400
racket.leftIsPressed = false
racket.rightIsPressed = false
racket.goingLeft = false
racket.goingRight = false

-- Déplacement de la raquette
function racket.moove(deltaTime)
	if (racket.goingLeft == true) then
		mooveToTheLeft(deltaTime)
	end
	if (racket.goingRight == true) then
		mooveToTheRight(deltaTime)
	end
end

-- Déplacement de la raquette sur la gauche
function mooveToTheLeft(deltaTime)
	racket.x = racket.x - racket.speed*deltaTime
end

-- Déplacement de la raquette sur la droite
function mooveToTheRight(deltaTime)
	racket.x = racket.x + racket.speed*deltaTime
end

-- Choix du sens de direction de la raquette en fonction de quelles touches sont pressées
-- Cette fonction est principalement la pour éviter les problèmes lors de l'appuie simultané dans les 2 directions
-- Elle permet de faire en sorte que la dernière direction choisis sois celle dans laquelle ce dirige la raquette
function whereToGo(direction, action)
	if (direction == 'q' and action == 'pressed') then
		racket.goingLeft = true
		racket.goingRight = false
	end
	
	if (direction == 'q' and action == 'released') then
		racket.goingLeft = false
		if (racket.rightIsPressed == true) then
			racket.goingRight = true
		end
	end
	
	if (direction == 'd' and action == 'pressed') then
		racket.goingRight = true
		racket.goingLeft = false
	end
	
	if (direction == 'd' and action == 'released') then
		racket.goingRight = false
		if (racket.leftIsPressed == true) then
			racket.goingLeft = true
		end
	end
end

-- Récupération des inputs pour la raquette
function racket.keypressed(key)
	if (key == 'q') then
		racket.leftIsPressed = true
	end
	if (key == 'd') then
		racket.rightIsPressed = true
	end
	whereToGo(key, 'pressed')
end

-- Récupération des fin d'inputs pour la raquette
function racket.keyreleased(key)
	if (key == 'q') then
		racket.leftIsPressed = false
	end
	if (key == 'd') then
		racket.rightIsPressed = false
	end
	whereToGo(key, 'released')
end

return racket