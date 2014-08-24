require "animated_sprite"

function love.load()
	love.window.setTitle("As The Crow Flies")
	particle = love.graphics.newImage("snow.png")

	snow_system = love.graphics.newParticleSystem(particle, 1000)

	snow_system:setEmissionRate(100)
	snow_system:setSpeed(1,3)
	snow_system:setLinearAcceleration(-20, 50, 20, 100)
	snow_system:setSizes(0.5,0.4,0.3)
	snow_system:setPosition(400,0)
	snow_system:setEmitterLifetime(-1)
	snow_system:setParticleLifetime(3,5.5)
	snow_system:setDirection(.45)
	snow_system:setAreaSpread("normal",300,0)
	snow_system:setColors(255,255,255,200)
	snow_system:start()

	animation = AnimatedSprite:create("crow_sprite.png", 139, 200, 9, 1)
	animation:load()
	animation:set_animation(true)
	animation_x = (love.graphics.getWidth() - animation.width)/2
	animation_y = (love.graphics.getHeight() - animation.height)/2

	font = love.graphics.newFont("AmaticSC-Regular.ttf", 60)
	love.graphics.setFont(font)

	lines = {}
	for line in love.filesystem.lines("poem.txt") do
		table.insert(lines, line)
	end

	line = 1
	delay = 0
	speed = 200
end

function love.update(dt)
	delay = delay + dt
	snow_system:update(dt)
	animation:update(dt)

	if delay >= 3 then
		line = (line % #lines) + 1
		delay = 0
	end

	if love.keyboard.isDown(" ") then
		animation_y = animation_y - speed * dt
	else
		animation_y = animation_y + speed * dt
	end
end


function love.draw()
	for x=1,love.graphics.getWidth() do
		for y=1, love.graphics.getHeight() do
			color_pick = math.random(2)
			if color_pick == 1 then
				love.graphics.setColor(211, 211, 211)
			else
				love.graphics.setColor(190, 190, 190)
			end
			love.graphics.point(x, y)
		end
	end

	love.graphics.setColor(255, 255, 255, 130)

	animation:draw(animation_x, animation_y)

	love.graphics.setColor(100, 100, 100, 255-(delay*80))

	love.graphics.printf(lines[line], 0, 100, love.graphics.getWidth(), "center")

	love.graphics.setColor(255, 255, 255)

	love.graphics.draw(snow_system)
end

function love.keypressed(key, isrepeat)
	if key == "escape" then
    	love.event.quit()
    end
end