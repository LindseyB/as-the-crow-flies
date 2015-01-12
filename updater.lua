function updater(dt)
	snow_system:update(dt)

	background = (background % #backgrounds) + 1

	if game_over then return end

	if show_menu then
		main_menu:hover_state(love.mouse.getX(), love.mouse.getY())
		return
	end

	text_update(dt)
	animation_update(dt)
	if not show_credits then collision_update(dt) end
end

function text_update(dt)
	text_x = text_x - text_speed * dt

	if line == #lines and show_credits then
		show_credits = false
		show_menu = true
		score = 0
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
		animation_y = animation_y - speed * dt
	else
		animation_y = animation_y + speed * dt
	end
end

function collision_update()
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