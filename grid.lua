-- Fichier représentant la grille de brique

local Grid = {}

-- Valeurs de la grille
Grid.initialNumberBrick = 0
Grid.actualNumberBrick = 0
Grid.length = 640

Grid.__index = Grid

function Grid:new(vars)
	local instance = setmetatable({}, Grid)
	instance.property = vars
    return instance
end

function Grid:reset()
	for i=1, 20 do
      self.property.actual[i] = {}
      for j=1, 36 do
        self.property.actual[i][j] = false
      end
    end
end

function Grid:setLvl1 ()
	for i = 1, 20 do
		for j = 1, 36 do
			if (i % 2 ~= 0 and j % 2 ~= 0 or i % 2 == 0 and j % 2 == 0) then
				self.property.actual[i][j] = true
			end
		end
	end
	self.initialNumberBrick = 320
	self.actualNumberBrick = 320
end

function Grid:setLvlTest ()
	self.property.actual[1][18] = true
	self.property.actual[20][18] = true
	self.property.actual[20][19] = true
	self.initialNumberBrick = 3
	self.actualNumberBrick = 3
end

function Grid:destroyBrick(i, j)
	self.property.actual[i][j] = false
	self.actualNumberBrick = self.actualNumberBrick - 1
end

return Grid






