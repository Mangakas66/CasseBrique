-- Controleur qui supervise les collisions des différents objets durant une partie

ControllerCollision = {}

ControllerCollision.__index = ControllerCollision

function ControllerCollision:new(vars)
	local instance = setmetatable({}, ControllerCollision)
    instance.property = vars
    return instance

end

-- Gestion des collissions de la balle
function ControllerCollision:ballCollision()
	if (self.property.ball.y <= 0 + self.property.ball.size/2) then
		self.property.ball.y = 0 + self.property.ball.size/2
		self.property.ball.velocityY = -self.property.ball.velocityY
	end
	if (self.property.ball.x <= 0 + self.property.ball.size/2) then
		self.property.ball.x = 0 + self.property.ball.size/2
		self.property.ball.velocityX = -self.property.ball.velocityX
	elseif (self.property.ball.x >= SCREEN_WIDTH - self.property.ball.size/2) then
		self.property.ball.x = SCREEN_WIDTH - self.property.ball.size/2
		self.property.ball.velocityX = -self.property.ball.velocityX
	end
end

return ControllerCollision