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

	object.submit = Button:create("Submit", x, 250, 200*scale, object.button_font:getHeight())


	object.button_list = {
		Button:create("Play Again", x, 250, 200*scale, object.button_font:getHeight()),
		Button:create("View Highscores", x, 250+object.button_font:getHeight()+padding, 200*scale, object.button_font:getHeight())
	}


	return object
end

function NameEntry:draw()
	love.graphics.setFont(self.title_font)
	love.graphics.printf("Highscore " .. score, 0, (50*scale), love.graphics.getWidth(), "center")
	love.graphics.printf("Enter Initials: " .. name, 0, (50+self.title_font:getHeight()*scale), love.graphics.getWidth(), "center")
	love.graphics.setFont(self.button_font)

	if self.submitted then
		for i, button in ipairs(self.button_list) do
			button:draw()
		end
	else
		self.submit:draw()
	end
end

function NameEntry:hover_state(x, y)

	if self.submitted then
		for i, button in ipairs(self.button_list) do
			button.hover = false
		end

		for i, button in ipairs(self.button_list) do
			if x >= button.x and x < button.x + button.width
			and y >= button.y and y < button.y + button.height then
				button.hover = true
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
			if x >= button.x and x < button.x + button.width
			and y >= button.y and y < button.y + button.height then
				return i
			end
		end
	else
		highscore.add(name, score)
		highscore.save()
		self.submitted = true
		love.keyboard.setTextInput(false)
	end

	return nil
end