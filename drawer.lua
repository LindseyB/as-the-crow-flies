function drawer()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(backgrounds[background])

	if state == States.Menu then
		main_menu:draw()
	elseif state == States.GameOver then
		game_over:draw()
	elseif state == States.Highscores then
		highscore_table:draw()
	elseif state == States.NameEntry then
		name_entry:draw()
	elseif state == States.Credits then
		credits:draw()
		game_draw()
	else
		game_draw()
	end

	snow_draw()
end

function game_draw()
	love.graphics.setFont(font)

	-- score
	if state == States.Play then love.graphics.print(score, 10, 10) end

	-- paused
	if state == States.Paused then love.graphics.printf("Push Space to Start", 0, love.graphics.getHeight()/2 - font:getHeight(), love.graphics.getWidth(), "center") end

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