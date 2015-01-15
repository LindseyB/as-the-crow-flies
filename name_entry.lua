require "button"

NameEntry = {}
NameEntry.__index = NameEntry

function NameEntry:create()
	local object = {}
	setmetatable(object, NameEntry)

	object.button_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 40*scale)
	object.title_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 80*scale)
	object.submitted = false

	padding = 20
	x = love.graphics.getWidth()/2 - ((200/2)*scale)

	object.submit = Button:create("Submit", x, (object.title_font:getHeight()+padding)*2 + padding*scale, 200*scale, object.button_font:getHeight())

	y = 150 * scale

	object.button_list = {
		Button:create("Play Again", x, y, 200*scale, object.button_font:getHeight()),
		Button:create("View Highscores", x, (y+object.button_font:getHeight()+padding), 200*scale, object.button_font:getHeight()),
		{},
		{},
		Button:create("Exit to Main", x, y+((object.button_font:getHeight()+padding)*3), 200*scale, object.button_font:getHeight())

	}


	return object
end

function NameEntry:draw()
	love.graphics.setFont(self.title_font)
	y = 50*scale
	love.graphics.printf("Highscore " .. score, 0, y, love.graphics.getWidth(), "center")
	if not self.submitted then
		love.graphics.printf("Enter Initials: " .. name, 0, y + self.title_font:getHeight(), love.graphics.getWidth(), "center")
	end

	love.graphics.setFont(self.button_font)

	if self.submitted then
		for i, button in ipairs(self.button_list) do
			if button.draw ~= nil then
				button:draw()
			end
		end
	else
		self.submit:draw()
	end
end

function NameEntry:hover_state(x, y)

	if self.submitted then
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
	else
			if x >= self.submit.x and x < self.submit.x + self.submit.width
			and y >= self.submit.y and y < self.submit.y + self.submit.height then
				self.submit.hover = true
			else
				self.submit.hover = false
			end
	end
end

function NameEntry:click(x, y)
	if self.submitted then
		for i, button in ipairs(self.button_list) do
			if button.draw ~= nil then
				if x >= button.x and x < button.x + button.width
				and y >= button.y and y < button.y + button.height then
					self.submitted = false
					return i
				end
			end
		end
	else
		if x >= self.submit.x and x < self.submit.x + self.submit.width
		and y >= self.submit.y and y < self.submit.y + self.submit.height then
			highscore.add(name, score)
			highscore.save()
			self.submitted = true
			love.keyboard.setTextInput(false)
		end
	end

	return nil
end
