require "button"

Credits = {}
Credits.__index = Credits

function Credits:create()
	local object = {}
	setmetatable(object, Credits)

	object.button_font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 40*scale)
	x = love.graphics.getWidth() - (200*scale) - 10
	y = love.graphics.getHeight() - object.button_font:getHeight() - 10
	object.button = Button:create("Return to Main", x, y, 200*scale, object.button_font:getHeight())

	return object
end

function Credits:draw()
	love.graphics.setFont(self.button_font)
	self.button:draw()
end

function Credits:hover_state(x, y)
	if x >= self.button.x and x < self.button.x + self.button.width
	and y >= self.button.y and y < self.button.y + self.button.height then
		self.button.hover = true
	else
		self.button.hover = false
	end
end

function Credits:click(x, y)
	if x >= self.button.x and x < self.button.x + self.button.width
	and y >= self.button.y and y < self.button.y + self.button.height then
		return Buttons.Menu
	else
		return nil
	end
end