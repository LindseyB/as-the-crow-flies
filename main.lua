require "animated_sprite"
require "bounding_box"
require "main_menu"
require "collision"
require "loader"


function love.load()
	loader()
end

function love.update(dt)
	snow_system:update(dt)
	animation:update(dt)

	background = (background % #backgrounds) + 1

	if show_menu then
		main_menu:hover_state(love.mouse.getX(), love.mouse.getY())
		return
	end

	if game_over then return end

	text_x = text_x - text_speed * dt

	if text_x <= -(font:getWidth(lines[line])) then
		score = score + 1

		if line == #lines then text_speed = text_speed + 50 end

		line = (line % #lines) + 1
		text_x = love.graphics.getWidth()
		text_y = math.random(love.graphics.getHeight()-font:getHeight())
	end

	if love.keyboard.isDown(" ") then
		animation_y = animation_y - speed * dt
	else
		animation_y = animation_y + speed * dt
	end

	bb = animation:getBoundingBox(animation_x, animation_y)
	if colliding_check(bb.x, bb.y, bb.width, bb.height,
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

	if show_menu then
		main_menu:draw()
	elseif game_over then
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

function love.mousepressed(x, y, button)
	if show_menu and button == "l" then
		clicked = main_menu:click(x,y)

		if clicked == main_menu.Buttons.Play then
			font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 80)
			love.graphics.setFont(font)
			show_menu = false
		elseif clicked == main_menu.Buttons.Exit then
			love.event.quit()
		end
	end
end

function reset()
	music:setPitch(1)
	animation_x = (love.graphics.getWidth() - animation.width)/2
	animation_y = (love.graphics.getHeight() - animation.height)/2
	text_x = love.graphics.getWidth()
	text_y = math.random(love.graphics.getHeight())
	line = 1
	text_speed = 200
	game_over = false
	score = 0
end
