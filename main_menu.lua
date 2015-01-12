require "button"

MainMenu = {}
MainMenu.__index = MainMenu

function MainMenu:create()
	local object = {}
	setmetatable(object, MainMenu)

	object.button_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 40)
	object.title_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 80)

	padding = 20

	x = love.graphics.getWidth()/2 - 100

	object.button_list = {
		Button:create("Play", x, 250, 200, object.button_font:getHeight()),
		Button:create("Highscores", x, 250+object.button_font:getHeight()+padding, 200, object.button_font:getHeight()),
		Button:create("Credits", x, 250+((object.button_font:getHeight()+padding)*2), 200, object.button_font:getHeight()),
		Button:create("Exit", x, 250+((object.button_font:getHeight()+padding)*3), 200, object.button_font:getHeight())
	}

	object.Buttons = {
		["Play"] = 1,
		["Highscores"] = 2,
		["Credits"] = 3,
		["Exit"] = 4
	}

	return object
end

function MainMenu:draw()
	love.graphics.setFont(self.title_font)
	love.graphics.printf("As The Crow Flies", 0, 100, love.graphics.getWidth(), "center")
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