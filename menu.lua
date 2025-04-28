-- Menu du jeu

local Menu = {}

Menu.title = {}
Menu.title.text = 'Casse Brique'
Menu.title.y = 200

Menu.color = {}
Menu.initialColor = {.5, .5, 1}
Menu.hoverColor = {1, .2, .2}

Menu.option = {}
Menu.option[1] = {}
Menu.option[1].text = "Jouer"
Menu.option[1].y = 400
Menu.option[1].underlineColor = Menu.initialColor
Menu.option[2] = {}
Menu.option[2].text = "Option"
Menu.option[2].y = 500
Menu.option[2].underlineColor = Menu.initialColor
Menu.option[3] = {}
Menu.option[3].text = "Quitter"
Menu.option[3].y = 600
Menu.option[3].underlineColor = Menu.initialColor
Menu.option.underlineWidth = 50

return Menu