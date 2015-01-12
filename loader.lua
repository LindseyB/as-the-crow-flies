function loader()
	love.window.setTitle("As The Crow Flies")
	love.window.setIcon(love.image.newImageData("assets/icon/icon.png"))

	modes = love.window.getFullscreenModes()
	table.sort(modes, function(a, b) return a.width*a.height > b.width*b.height end)
	love.window.setMode(modes[1].width, modes[1].height, {fullscreen=true})

	load_snow()
	load_animation()
	load_background()
	load_poem()
	load_music()

	text_x = love.graphics.getWidth()
	text_y = math.random(love.graphics.getHeight())

	main_menu = MainMenu:create()

	background = 1
	line = 1
	speed = 200
	text_speed = 200
	score = 0
	game_over = false
	show_menu = true
	show_credits = false
end

function load_snow()
	particle = love.graphics.newImage("assets/sprites/snow.png")
	snow_system = love.graphics.newParticleSystem(particle, 2000)

	snow_system:setEmissionRate(100)
	snow_system:setSpeed(1,3)
	snow_system:setLinearAcceleration(-20, 50, 20, 100)
	snow_system:setSizes(0.5,0.4,0.3)
	snow_system:setPosition(400,0)
	snow_system:setEmitterLifetime(-1)
	snow_system:setParticleLifetime(10, 20, 30)
	snow_system:setDirection(.45)
	snow_system:setAreaSpread("normal",love.graphics.getWidth(),0)
	snow_system:setColors(255,255,255,200)
	snow_system:start()
end

function load_animation()
	animation = AnimatedSprite:create("assets/sprites/crow_sprite.png", 139, 200, 9, 1)
	animation:load()
	animation:set_animation(true)
	animation_x = (love.graphics.getWidth() - animation.width)/2
	animation_y = (love.graphics.getHeight() - animation.height)/2
end

function load_background()
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
end

function load_poem()
	lines = {}

	file = "assets/poems/admonition.txt"

	if os.date("%B") == "January" and os.date("%d") == 19 then
		file = "assets/poems/secret.txt"
	end

	for line in love.filesystem.lines(file) do
		if line ~= "" then
			table.insert(lines, line)
		end
	end
end

function load_credits()
	lines = {}

	for line in love.filesystem.lines("assets/credits.txt") do
		if line ~= "" then
			table.insert(lines, line)
		end
	end
end

function load_music()
	music = love.audio.newSource("assets/music/0101GhostsI.mp3")
	music:setLooping(true)
	music:play()
end