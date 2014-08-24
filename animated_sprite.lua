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

	return object
end

function AnimatedSprite:load()
	-- read in the walk animation

	for i = 1, self.animations do
		local h = self.height * (i-1)
		self.sprites[i] = {}
		for j = 1, self.frames do
			local w = self.width * (j-1)
			self.sprites[i][j] = love.graphics.newQuad(	w,
														h,
														self.width,
														self.height,
														self.sprite_sheet:getWidth(),
														self.sprite_sheet:getHeight())
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
