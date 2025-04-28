-- Fichier représantant une balle
-- Bien que pour l'instant il n'y en ai qu'une, il y aura définitivement plusieurs balle dans le futur

local Ball = {}

Ball.size = 20
Ball.x = 0
Ball.y = 0
Ball.velocityX = 0
Ball.timerVX = love.timer.getTime()
Ball.velocityY = 0
Ball.timerVY = love.timer.getTime()
Ball.isMooving = false

Ball.__index = Ball

function Ball:new(vars)
	local instance = setmetatable({}, Ball)
	instance.property = vars
    return instance
end

function Ball:start()
	self.velocityX = 0
	self.velocityY = -300
	self.isMooving = true
end

function Ball:moove(deltaTime)
	self.x = self.x + self.velocityX*deltaTime
	self.y = self.y + self.velocityY*deltaTime
end

function Ball:reverseVelocity(vars)
	local now = love.timer.getTime()
	if (vars == 'x' and now - self.timerVX >= .0001) then
		-- Renforce l'effet de rebond lors de la collision horizontal pour éviter que la balle enchaine plusieurs briques sur l'axe y sans modifier suffisement sa trajectoire lorsqu'elle a une velocité sur x trop faible
		if (self.velocityX >= 0) then
			self.velocityX = self.velocityX + 10
		else
			self.velocityX = self.velocityX - 10
		end
		self.velocityX = -self.velocityX
		self.timerVX = now
	elseif (vars == 'y' and now - self.timerVY >= .0001) then
		self.velocityY = -self.velocityY
		self.timerVY = now
	end
end

-- Pour quand il y aura plusieurs balles
function Ball:destroy()
	if (self.y > SCREEN_HEIGHT) then
		-- TODO DESTROY BALL
	end
end

return Ball