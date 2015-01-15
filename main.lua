require "animated_sprite"
require "bounding_box"
require "main_menu"
require "collision"
require "loader"
require "updater"
require "drawer"
require "sick"
require "highscore_table"
require "name_entry"
require "game_over"


function love.load()
	loader()
end

function love.update(dt)
	updater(dt)
end


function love.draw()
	drawer()
end

function love.keypressed(key, isrepeat)
	if key == "escape" then
		highscore.save()
		love.event.quit()
	elseif state == States.Paused and key == " " then
		state = States.Play
	elseif state == States.Play and key == "p" then
		state = States.Paused
	elseif state == States.NameEntry and key == "backspace" then
		name = name:sub(1, #name - 1)
	end
end

function love.textinput(t)
	if string.len(name) < 3 then
		name = name .. t
	end
end

function love.mousepressed(x, y, button)
	love.graphics.setFont(font)
	if (state ~= States.Play and state ~= States.Credits) and button == "l" then
		if state == States.Menu then clicked = main_menu:click(x,y) end
		if state == States.Highscores then clicked = highscore_table:click(x,y) end
		if state == States.NameEntry then clicked = name_entry:click(x,y) end
		if state == States.GameOver then clicked = game_over:click(x,y) end

		if clicked == Buttons.Play then
			reset()
			load_poem()
			love.mouse.setVisible(false)
			state = States.Paused
		elseif clicked == Buttons.Credits then
			love.mouse.setVisible(false)
			load_credits()
			state = States.Credits
		elseif clicked == Buttons.Highscores then
			state = States.Highscores
		elseif clicked == Buttons.Menu then
			state = States.Menu
		elseif clicked == Buttons.Exit then
			highscore.save()
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
	text_speed = 200*scale
	score = 0
end
