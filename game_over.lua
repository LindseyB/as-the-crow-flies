require "button"

GameOver = {}
GameOver.__index = GameOver

function GameOver:create()
	local object = {}
	setmetatable(object, GameOver)

	object.button_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 40*scale)
	object.title_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 80*scale)

	object.button_list = {
		Button:create("Play Again", x, 250, 200*scale, object.button_font:getHeight()),
		{},
		{},
		{},
		Button:create("Exit to Main", x, 250+object.button_font:getHeight()+padding, 200*scale, object.button_font:getHeight())
	}

	return object
end

function GameOver:draw()
	love.graphics.setFont(self.title_font)
	love.graphics.printf("Game Over", 0, (50*scale), love.graphics.getWidth(), "center")
	love.graphics.setFont(self.button_font)

	for i, button in ipairs(self.button_list) do
		if button.draw ~= nil then
			button:draw()
		end
	end
end

function GameOver:hover_state(x, y)
	for i, button in ipairs(self.button_list) do
		if button.hover ~= nil then
			button.hover = false
		end
	end

	for i, button in ipairs(self.button_list) do
		if button.hover ~= nil then
			if x >= button.x and x < button.x + button.width
			and y >= button.y and y < button.y + button.height then
				button.hover = true
			end
		end
	end
end

function GameOver:click(x, y)
	for i, button in ipairs(self.button_list) do
		if button.draw ~= nil then
			if x >= button.x and x < button.x + button.width
			and y >= button.y and y < button.y + button.height then
				return i
			end
		end
	end
end