BoundingBox = {}
BoundingBox.__index = BoundingBox

function BoundingBox:create(x, y, width, height)
	local object = {}

	setmetatable(object, BoundingBox)

	object.base_x = x
	object.base_y = y
	object.x = x
	object.y = y
	object.width = width
	object.height = height

	return object
end

function BoundingBox:position_adjusted(x, y)
	self.x = self.base_x + x
	self.y = self.base_y + y
end