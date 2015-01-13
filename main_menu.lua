require "button"

MainMenu = {}
MainMenu.__index = MainMenu

function MainMenu:create()
	local object = {}
	setmetatable(object, MainMenu)

	object.button_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 40*scale)
	object.title_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 80*scale)

	padding = 20

	x = love.graphics.getWidth()/2 - ((200/2)*scale)
	y = 150*scale

	object.button_list = {
		Button:create("Play", x, y, 200*scale, object.button_font:getHeight()),
		Button:create("Highscores", x, (y+object.button_font:getHeight()+padding), 200*scale, object.button_font:getHeight()),
		Button:create("Credits", x, y+((object.button_font:getHeight()+padding)*2), 200*scale, object.button_font:getHeight()),
		Button:create("Exit", x, y+((object.button_font:getHeight()+padding)*3), 200*scale, object.button_font:getHeight())
	}

	return object
end

function MainMenu:draw()
	love.graphics.setFont(self.title_font)
	love.graphics.printf("As The Crow Flies", 0, (50*scale), love.graphics.getWidth(), "center")
	love.graphics.setFont(self.button_font)

	for i, button in ipairs(self.button_list) do
		button:draw()
	end
end

function MainMenu:hover_state(x, y)
	for i, button in ipairs(self.button_list) do
		button.hover = false
	end

	for i, button in ipairs(self.button_list) do
		if x >= button.x and x < button.x + button.width
		and y >= button.y and y < button.y + button.height then
			button.hover = true
		end
	end
end

function MainMenu:click(x, y)
	for i, button in ipairs(self.button_list) do
		if x >= button.x and x < button.x + button.width
		and y >= button.y and y < button.y + button.height then
			return i
		end
	end

	return nil
end