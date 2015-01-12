require "animated_sprite"
require "bounding_box"
require "main_menu"
require "collision"
require "loader"
require "updater"
require "drawer"


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
		elseif clicked == main_menu.Buttons.Credits then
			font = love.graphics.newFont("assets/fonts/AmaticSC-Regular.ttf", 80)
			love.graphics.setFont(font)
			load_credits()
			show_menu = false
			show_credits = true
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
