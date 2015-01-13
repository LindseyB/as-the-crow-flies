function updater(dt)
	snow_system:update(dt)

	background = (background % #backgrounds) + 1

	if state == States.Paused then return end

	if state == States.Highscores then
		highscore_table:hover_state(love.mouse.getX(), love.mouse.getY())
		return
	end

	if state == States.Menu then
		main_menu:hover_state(love.mouse.getX(), love.mouse.getY())
		return
	end

	if state == States.NameEntry then
		name_entry:hover_state(love.mouse.getX(), love.mouse.getY())
		return
	end

	if state == States.GameOver then
		game_over:hover_state(love.mouse.getX(), love.mouse.getY())
		return
	end

	text_update(dt)
	animation_update(dt)

	if state == States.Play then collision_update(dt) end
end

function text_update(dt)
	text_x = text_x - text_speed * dt

	if state == States.Credits and text_x <= -(font:getWidth(lines[line])) then
		if line == #lines then
			state = States.Menu
			score = 0
		end
	end

	if text_x <= -(font:getWidth(lines[line])) then
		score = score + 1

		if line == #lines then text_speed = text_speed + 50 end

		line = (line % #lines) + 1
		text_x = love.graphics.getWidth()
		text_y = math.random(love.graphics.getHeight()-font:getHeight())
	end
end

function animation_update(dt)
	animation:update(dt)
	if love.keyboard.isDown(" ") then
		animation_y = animation_y - speed * dt * scale
	else
		animation_y = animation_y + speed * dt * scale
	end
end

function collision_update()
	bb = animation:getBoundingBox(animation_x, animation_y)
	if colliding_check(bb.x, bb.y, bb.width, bb.height,
		text_x, text_y, font:getWidth(lines[line]), font:getHeight()) then
		process_gameover()
	elseif animation_y >= love.graphics.getHeight() or animation_y <= -(animation.height) then
		process_gameover()
	end
end

function process_gameover()
	if score > highscore.scores[8][1] then
		love.keyboard.setTextInput(true)
		state = States.NameEntry
	else
		state = States.GameOver
		music:setPitch(0.5)
	end
end