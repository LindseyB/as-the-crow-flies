require "button"

HighscoreTable = {}
HighscoreTable.__index = HighscoreTable

function HighscoreTable:create()
	local object = {}
	setmetatable(object, HighscoreTable)

	object.button_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 40*scale)
	object.title_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 80*scale)

	x = love.graphics.getWidth() - (200*scale) - 10
	y = love.graphics.getHeight() - object.button_font:getHeight() - 10
	object.button = Button:create("Return to Main", x, y, 200*scale, object.button_font:getHeight())

	return object
end


function HighscoreTable:draw()
	love.graphics.setFont(self.title_font)
	love.graphics.printf("As The Crow Flies Highscores", 0, (50*scale), love.graphics.getWidth(), "center")

	love.graphics.setFont(self.button_font)
	for i, score, name in highscore() do
		love.graphics.printf(i .. ". " .. name .. " - " .. score, 0, (120*scale)+(i*self.button_font:getHeight()), love.graphics.getWidth(), "center")
	end
	self.button:draw()
end

function HighscoreTable:hover_state(x, y)

	if x >= self.button.x and x < self.button.x + self.button.width
	and y >= self.button.y and y < self.button.y + self.button.height then
		self.button.hover = true
	else
		self.button.hover = false
	end
end

function HighscoreTable:click(x, y)
	if x >= self.button.x and x < self.button.x + self.button.width
	and y >= self.button.y and y < self.button.y + self.button.height then
		return Buttons.Menu
	else
		return nil
	end
end