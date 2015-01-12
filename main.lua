require "animated_sprite"
require "bounding_box"
require "main_menu"
require "collision"
require "loader"
require "updater"
require "drawer"
require "sick"
require "highscore_table"


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
	elseif game_over and key == " " then
		reset()
	end
end

function love.mousepressed(x, y, button)
	if (show_menu or show_highscore) and button == "l" then
		if show_menu then clicked = main_menu:click(x,y) end
		if show_highscore then clicked = highscore_table:click(x,y) end


		if clicked == Buttons.Play then
			show_menu = false
		elseif clicked == Buttons.Credits then
			load_credits()
			show_menu = false
			show_credits = true
		elseif clicked == Buttons.Highscores then
			show_menu = false
			show_highscore = true
		elseif clicked == Buttons.Menu then
			show_highscore = false
			show_menu = true
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
	text_speed = 200
	game_over = false
	score = 0
end
