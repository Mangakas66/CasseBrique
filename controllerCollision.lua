-- Controleur qui supervise les collisions des différents objets durant une partie
local Brick = require('brick')

local ControllerCollision = {}

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
		self.property.ball:reverseVelocity('y')
	end
	if (self.property.ball.x <= 0 + self.property.ball.size/2) then
		self.property.ball.x = 0 + self.property.ball.size/2
		self.property.ball:reverseVelocity('x')
	elseif (self.property.ball.x >= SCREEN_WIDTH - self.property.ball.size/2) then
		self.property.ball.x = SCREEN_WIDTH - self.property.ball.size/2
		self.property.ball:reverseVelocity('x')
	end
	if (self.property.ball.y + self.property.ball.size/2 >= self.property.racket.y - self.property.racket.height/2 and self.property.ball.y + self.property.ball.size/2 <= self.property.racket.y and self.property.ball.x + self.property.ball.size/3 >= self.property.racket.x - self.property.racket.width/2 and self.property.ball.x - self.property.ball.size/3 <= self.property.racket.x + self.property.racket.width/2) then
		self:racketRebound()
	end
	
	for i = 1, 20 do
		for j = 1, 36 do
		-- Si la brique existe
			if (self.property.grid.property.actual[i][j] == true) then
				-- Collision avec le haut et le bas de la brique
				if (self.property.ball.x + self.property.ball.size/3 >= j*Brick.width - Brick.width and self.property.ball.x - self.property.ball.size/3 <= j*Brick.width) then
					if (self.property.ball.y - self.property.ball.size/2 <= i*Brick.height and self.property.ball.y - self.property.ball.size/2 >= i*Brick.height - Brick.height/2 or self.property.ball.y + self.property.ball.size/2 >= i*Brick.height - Brick.height and self.property.ball.y + self.property.ball.size/2 <= i*Brick.height - Brick.height/2) then
						self.property.ball:reverseVelocity('y')
						self.property.grid:destroyBrick(i, j)
					end
				end
				-- Collision avec les cotés de la brique
				if (self.property.ball.y + self.property.ball.size/3 >= i*Brick.height - Brick.height and self.property.ball.y - self.property.ball.size/3 <= i*Brick.height) then
					if (self.property.ball.x - self.property.ball.size/2 <= j*Brick.width and self.property.ball.x - self.property.ball.size/2 >= j*Brick.width - Brick.width/2 or self.property.ball.x + self.property.ball.size/2 >= j*Brick.width - Brick.width and self.property.ball.x + self.property.ball.size/2 <= j*Brick.width - Brick.width/2) then
						self.property.ball:reverseVelocity('x')
						self.property.grid:destroyBrick(i, j)
					end
				end
			end
		end
	end
end

function ControllerCollision:racketRebound()
	self.property.ball.y = self.property.racket.y - self.property.racket.height/2 - self.property.ball.size/2
	self.property.ball.velocityY = -self.property.ball.velocityY
	if (self.property.racket.goingRight == true and self.property.ball.velocityX < 350) then
		self.property.ball.velocityX = self.property.ball.velocityX + self.property.racket.speed/3 - love.math.random() * 20
	elseif (self.property.racket.goingLeft == true and self.property.ball.velocityX > -350) then
		self.property.ball.velocityX = self.property.ball.velocityX - self.property.racket.speed/3 + love.math.random() * 20
	end
end

return ControllerCollision