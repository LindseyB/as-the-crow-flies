require "bounding_box"

AnimatedSprite = {}
AnimatedSprite.__index = AnimatedSprite

function AnimatedSprite:create(file, width, height, frames, animations)
	local object = {}

	setmetatable(object, AnimatedSprite)

	object.width = width
	object.height = height
	object.frames = frames
	object.animations = animations
	object.sprite_sheet = love.graphics.newImage(file)
	object.sprites = {}
	object.current_frame = 1
	object.current_animation = 1
	object.delay = 0.08
	object.delta = 0
	object.animating = false
	object.Directions = {
		["Down"] = 1,
		["Left"] = 2,
		["Right"] = 1,
		["Up"] = 1
	}
	object.bounding_boxes = {}

	return object
end

function AnimatedSprite:load()
	imageData = self.sprite_sheet:getData()

	for i = 1, self.animations do
		local h = self.height * (i-1)
		self.sprites[i] = {}
		self.bounding_boxes[i] = {}
		for j = 1, self.frames do
			local w = self.width * (j-1)
			self.sprites[i][j] = love.graphics.newQuad(	w,
														h,
														self.width,
														self.height,
														self.sprite_sheet:getWidth(),
														self.sprite_sheet:getHeight())

			-- calculate the bounding boxes from alpha sprites
			min_x = self.sprite_sheet:getWidth()
			min_y = self.sprite_sheet:getHeight()
			max_x = 0
			max_y = 0
			for y = h, (self.height + h - 1) do
				for x = w, (self.width + w - 1) do
					r, g, b, a = imageData:getPixel(x,y)
					if a ~= 0 then
						if x < min_x then min_x = x end
						if x > max_x then max_x = x end
						if y < min_y then min_y = y end
						if y > max_y then max_y = y end
					end
				end
			end
			self.bounding_boxes[i][j] = BoundingBox:create( min_x-(self.width*(j-1)),
				                                            min_y,
				                                            max_x-(self.width*(j-1)),
				                                            max_y-min_y)
		end
	end
end

function AnimatedSprite:update(dt)
	if self.animating then
		self.delta = self.delta + dt

		if self.delta >= self.delay then
			self.current_frame = (self.current_frame % self.frames) + 1
			self.delta = 0
		end
	end
end

function AnimatedSprite:draw(x, y)
	love.graphics.draw(self.sprite_sheet, self.sprites[self.current_animation][self.current_frame], x, y, 0, 1, 1)
end

function AnimatedSprite:set_animation(animating)
	self.animating = animating

	if not animating then
		self.current_frame = 1
	end
end

function AnimatedSprite:set_animation_direction(direction)
	self.animating = true
	self.current_animation = direction
end

function AnimatedSprite:getBoundingBox(x, y)
	self.bounding_boxes[self.current_animation][self.current_frame]:position_adjusted(x, y)
	return self.bounding_boxes[self.current_animation][self.current_frame]
end