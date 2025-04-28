-- Fichier de lancement du logiciel
-- Le stricit minimum de code doit être conservé ici pour ne garder que la logique abstraite du jeu
local Game = require('game')

-- Chargement des variables
function love.load()
	Game.load()
end

-- Actualisation du jeu
function love.update(deltaTime)
	Game.update(deltaTime)
end

-- Affichage du jeu
function love.draw()
	Game.draw()
end

-- Récupère les inputs du clavier
function love.keypressed(key)
	Game.keypressed(key)
end

-- Récupère les fin d'inputs du clavier
function love.keyreleased(key)
	Game.keyreleased(key)
end