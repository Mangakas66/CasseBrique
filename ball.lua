-- Fichier représantant une balle
-- Bien que pour l'instant il n'y en ai qu'une, il y aura définitivement plusieurs balle dans le futur

local ball = {}

ball.size = 20
ball.x = 0
ball.y = 0
ball.velocityX = 0
ball.velocityY = 0
ball.isMooving = false

function ball.start()
	ball.velocityX = 500
	ball.velocityY = -300
	ball.isMooving = true
end

function ball.moove(deltaTime)
	ball.x = ball.x + ball.velocityX*deltaTime
	ball.y = ball.y + ball.velocityY*deltaTime
end

function ball.destroy()
	if (ball.y > SCREEN_HEIGHT) then
		-- TODO DESTROY BALL
	end
end

return ball