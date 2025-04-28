-- Fichier représantant une balle
-- Bien que pour l'instant il n'y en ai qu'une, il y aura définitivement plusieurs balle dans le futur

local Ball = {}

Ball.size = 20
Ball.x = 0
Ball.y = 0
Ball.velocityX = 0
Ball.velocityY = 0
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
	if (vars == 'x') then
		self.velocityX = -self.velocityX
	elseif (vars == 'y') then
		self.velocityY = -self.velocityY
	end
end

-- Pour quand il y aura plusieurs balles
function Ball:destroy()
	if (self.y > SCREEN_HEIGHT) then
		-- TODO DESTROY BALL
	end
end

return Ball