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
	text_x = love.graphics.getWidth()
	text_y = math.random(love.graphics.getHeight())

	font = love.graphics.newFont("AmaticSC-Regular.ttf", 80)
	love.graphics.setFont(font)

	-- generate all the background noise images
	backgrounds = {}
	canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.setCanvas(canvas)
	for i=1,10 do
		canvas:clear()
		for x=1, canvas:getWidth() do
			for y=1, canvas:getHeight() do
				color_pick = math.random(2)
				if color_pick == 1 then
					love.graphics.setColor(211, 211, 211, 255)
				else
					love.graphics.setColor(190, 190, 190, 255)
				end
				love.graphics.point(x, y)
			end
		end
		table.insert(backgrounds, love.graphics.newImage(canvas:getImageData()))
	end
	love.graphics.setCanvas()

	lines = {}
	for line in love.filesystem.lines("poem.txt") do
		if line ~= "" then
			table.insert(lines, line)
		end
	end

	music = love.audio.newSource("0101GhostsI.mp3")
	music:setLooping(true)
	music:play()

	background = 1
	line = 1
	speed = 200
	text_speed = 200
	score = 0
	game_over = false
end

function love.update(dt)
	snow_system:update(dt)
	animation:update(dt)

	background = (background % #backgrounds) + 1

	if game_over then return end

	text_x = text_x - speed * dt

	if text_x <= -(font:getWidth(lines[line])) then
		score = score + 1
		line = (line % #lines) + 1
		text_x = love.graphics.getWidth()
		text_y = math.random(love.graphics.getHeight()-font:getHeight())
	end

	if love.keyboard.isDown(" ") then
		animation_y = animation_y - speed * dt
	else
		animation_y = animation_y + speed * dt
	end

	if colliding_check(animation_x, animation_y, animation.width, animation.height,
		text_x, text_y, font:getWidth(lines[line]), font:getHeight()) then
		game_over = true
		music:setPitch(0.5)
	elseif animation_y >= love.graphics.getHeight() or animation_y <= -(animation.height) then
		game_over = true
		music:setPitch(0.5)
	end
end


function love.draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(backgrounds[background])

	if game_over then
		love.graphics.setColor(100, 100, 100, 255)
		love.graphics.printf("Game Over - Press Space\nYour Score Was: " .. score, 0, 100, love.graphics.getWidth(), "center")
	else
		-- score
		love.graphics.print(score, 10, 10)

		-- crow
		love.graphics.setColor(255, 255, 255, 130)
		animation:draw(animation_x, animation_y)

		-- poem
		love.graphics.setColor(100, 100, 100, 255)
		love.graphics.print(lines[line], text_x, text_y)
	end

	-- snow
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(snow_system)
end

function love.keypressed(key, isrepeat)
	if key == "escape" then
		love.event.quit()
	elseif game_over and key == " " then
		reset()
	end
end


function colliding_check(x1,y1,w1,h1,x2,y2,w2,h2)
	return x1 < x2+w2 and
		x2 < x1+w1 and
		y1 < y2+h2 and
		y2 < y1+h1
end

function reset()
	music:setPitch(1)
	animation_x = (love.graphics.getWidth() - animation.width)/2
	animation_y = (love.graphics.getHeight() - animation.height)/2
	text_x = love.graphics.getWidth()
	text_y = math.random(love.graphics.getHeight())
	line = 1
	game_over = false
	score = 0
end
