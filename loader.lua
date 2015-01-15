function loader()
	love.window.setTitle("As The Crow Flies")
	love.window.setIcon(love.image.newImageData("assets/icon/icon.png"))

	modes = love.window.getFullscreenModes()
	table.sort(modes, function(a, b) return a.width*a.height > b.width*b.height end)
	love.window.setMode(modes[1].width, modes[1].height, {fullscreen=true})
	scale = love.graphics.getHeight()/600

	love.keyboard.setTextInput(false)
	highscore.set("highscores.txt", 8, "AAA", 5)

	font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 80*scale)

	load_snow()
	load_animation()
	load_background()
	load_poem()
	load_music()

	text_x = love.graphics.getWidth()
	text_y = math.random(love.graphics.getHeight())

	main_menu = MainMenu:create()
	highscore_table = HighscoreTable:create()
	name_entry = NameEntry:create()
	game_over = GameOver:create()

	background = 1
	speed = 200
	text_speed = 200*scale
	name = ""

	Buttons = {
		["Play"] = 1,
		["Highscores"] = 2,
		["Credits"] = 3,
		["Exit"] = 4,
		["Menu"] = 5
	}

	States = {
		["Play"] = 1,
		["Highscores"] = 2,
		["Credits"] = 3,
		["Menu"] = 4,
		["GameOver"] = 5,
		["NameEntry"] = 6,
		["Paused"] = 7
	}

	state = States.Menu
end

function load_snow()
	particle = love.graphics.newImage("assets/sprites/snow.png")
	snow_system = love.graphics.newParticleSystem(particle, 2000*scale)

	snow_system:setEmissionRate(100*scale)
	snow_system:setSpeed(1,3)
	snow_system:setLinearAcceleration(-20, 50, 20, 100)
	snow_system:setSizes(0.5*scale,0.4*scale,0.3*scale)
	snow_system:setPosition(400,0)
	snow_system:setEmitterLifetime(-1)
	snow_system:setParticleLifetime(10, 20, 30)
	snow_system:setDirection(.45)
	snow_system:setAreaSpread("normal",love.graphics.getWidth(),0)
	snow_system:setColors(255,255,255,200)
	snow_system:start()
end

function load_animation()
	animation = AnimatedSprite:create("assets/sprites/crow_sprite.png", 139, 200, 9, 1, scale)
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
	font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 80*scale)
	love.graphics.setFont(font)
	lines = {}
	line = 1

	for line in love.filesystem.lines("assets/credits.txt") do
		if line ~= "" then
			table.insert(lines, line)
		end
	end
end

function load_music()
	music = love.audio.newSource("assets/music/L'ultima pioggia (last rain).mp3")
	music:setLooping(true)
	music:play()
end
