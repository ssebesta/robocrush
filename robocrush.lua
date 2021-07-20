player = new_player(64,64)
enemy_array = new_array()
bullet_array = new_array()
explosion_array = new_array()
particle_exp_array = new_array()
uimanager = new_uimanager()

level1 = split(level1string)

for xstring in all(level1) do
	x = split(xstring, ":")
	if (x[1] == "groff") then
		groff = new_groff(x[2], x[3], player)
		add(enemy_array, groff)
	elseif(x[1] == "alien") then
		alien = new_alien(x[2], x[3], player)
		add(enemy_array, alien)
	end
end

function _update()
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