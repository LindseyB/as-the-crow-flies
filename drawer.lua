function drawer()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(backgrounds[background])

	if state == States.Menu then
		main_menu:draw()
	elseif state == States.GameOver then
		game_over_draw()
	elseif state == States.Highscores then
		highscore_table:draw()
	else
		game_draw()
	end

	snow_draw()
end

function game_over_draw()
	love.graphics.setColor(100, 100, 100, 255)
	love.graphics.printf("Game Over - Press Space\nYour Score Was: " .. score, 0, 100, love.graphics.getWidth(), "center")
end

function game_draw()
	love.graphics.setFont(font)
	-- score
	if state == States.Play then love.graphics.print(score, 10, 10) end

	-- crow
	love.graphics.setColor(255, 255, 255, 130)
	animation:draw(animation_x, animation_y)

	-- poem
	love.graphics.setColor(100, 100, 100, 255)
	love.graphics.print(lines[line], text_x, text_y)
end

function snow_draw()
	-- snow
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(snow_system)
end