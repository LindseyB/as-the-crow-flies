require "button"

MainMenu = {}
MainMenu.__index = MainMenu

function MainMenu:create()
	local object = {}
	setmetatable(object, MainMenu)

	object.button_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 30)
	object.title_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 80)

	padding = 20

	object.play_button = Button:create("Play", 300, 250, 200, object.button_font:getHeight())
	object.highscore_button = Button:create("Highscores", 300, 250+object.button_font:getHeight()+padding, 200, object.button_font:getHeight())
	object.credits_button = Button:create("Credits", 300, 250+((object.button_font:getHeight()+padding)*2), 200, object.button_font:getHeight())
	object.exit_button = Button:create("Exit", 300, 250+((object.button_font:getHeight()+padding)*3), 200, object.button_font:getHeight())

	return object
end

function MainMenu:draw()
	love.graphics.setFont(self.title_font)
	love.graphics.printf("As The Crow Flies", 0, 100, love.graphics.getWidth(), "center")
	love.graphics.setFont(self.button_font)
	self.play_button:draw()
	self.highscore_button:draw()
	self.credits_button:draw()
	self.exit_button:draw()
end