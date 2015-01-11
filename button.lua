Button = {}
Button.__index = Button

function Button:create(text, x, y, width, height)
	local object = {}

	setmetatable(object, Button)

	object.text = text
	object.x = x
	object.y = y
	object.width = width
	object.height = height
	object.hover = false

	return object
end

function Button:draw()
	if self.hover then
		love.graphics.setColor(60, 60, 60, 220)
	else
		love.graphics.setColor(60, 60, 60, 130)
	end

	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.setColor(200, 200, 200, 255)
	love.graphics.printf(self.text, self.x, self.y, self.width, "center")
end