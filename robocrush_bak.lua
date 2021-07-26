player = new_player(64,64)
enemy_array = new_array()
bullet_array = new_array()
explosion_array = new_array()
particle_exp_array = new_array()
uimanager = new_uimanager()

function load_level()
	level = split(levels[curlevel])
	
	for xstring in all(level) do
		x = split(xstring, ":")
		if (x[1] == "groff") then
			groff = new_groff(x[2], x[3], player)
			add(enemy_array, groff)
		elseif(x[1] == "alien") then
			alien = new_alien(x[2], x[3], player)
			add(enemy_array, alien)
		end
	end	
end

function restart_after_death()
	for enemy in all(enemy_array) do
		enemy.posx = enemy.orig_posx
		enemy.posy = enemy.orig_posy
	end
	
	for bullet in all(bullet_array) do del(bullet_array, bullet) end
	for exp in all(explosion_array) do del(explosion_array, exp) end
end

function _update()
	if (gamestate == "NEW_LEVEL") then
		load_level()
		gamestate = "PLAYING"
	elseif (gamestate == "PLAYER_DEAD") then
		player.dead = false
		player.posx = player.orig_posx
		player.posy = player.orig_posy
		
		if (uimanager.players > 0) then
			uimanager.players -= 1
			restart_after_death()
			gamestate = "PLAYING"
		else
			gamestate = "GAME_OVER"
		end
	elseif (count(enemy_array) == 0) then
		gamestate = "NEW_LEVEL"
		curlevel += 1
	elseif (gamestate == "GAME_OVER") then		
	end
	
	player.update(player)

	cleanup_array(enemy_array)
	cleanup_array(bullet_array)
	cleanup_array(explosion_array)

end

function _draw()
	cls(0)

	player.draw(player)

	if (not player.dead) then		
		bullet_array.draw(bullet_array)
		enemy_array.draw(enemy_array)
		explosion_array.draw(explosion_array)
		particle_exp_array.draw(particle_exp_array)		
	end

	uimanager.draw(uimanager)
	map(0, 0, 0, 0, 128, 32)
end