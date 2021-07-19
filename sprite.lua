function new_sprite(x,y, _width, _height, _spr_num)
	local sprite = {
		posx = x,
		posy = y,
		spr_num = _spr_num,
		width = _width,
		height = _height,
		dead = false
	}

	return sprite
end

function new_enemy(x, y, _width, _height, _spr_num, _explosion_num, _player)
	enemy_count = enemy_count + 1	

	local enemy = new_sprite(x, y, _width, _height, _spr_num)

	enemy.player = _player
	enemy.explosion_num = _explosion_num
	enemy.id = enemy_count
	enemy.move_distance = 1
	enemy.frames_per_move = 1
	enemy.num_walking_frames = 4
	enemy.spr_num_array = { 9, 10 }
	enemy.spr_num_count = 1	
	enemy.num_sprites_x = 1
	enemy.num_sprites_y = 1
	enemy.hit_points = 1
	enemy.color = 1
	enemy.particle_frame_max = 60
	enemy.num_particles = 20
	enemy.points = 100

	enemy.draw_sprite = function(self)
		for i=0, self.num_sprites_x - 1 do
			for j=0, self.num_sprites_y - 1 do
				spr(self.spr_num + i + (16 * j), self.posx + (i * 8), self.posy + (j * 8))
			end	
		end	
	end

	enemy.move_toward_player = function(self)
		local xinc = 0
		local yinc = 0

		if (self.num_walking_frames == self.frames_per_move) then

			if (self.player.posx > self.posx) then
				xinc = self.move_distance
			elseif (self.player.posx < self.posx) then
				xinc = -self.move_distance
			end

			if (self.player.posy > self.posy) then
				yinc = self.move_distance
			elseif (self.player.posy < self.posy) then
				yinc = -self.move_distance
			end			

			if (self.spr_num_count == count(self.spr_num_array)) then self.spr_num_count = 1 else self.spr_num_count = self.spr_num_count + 1 end

			self.spr_num = self.spr_num_array[self.spr_num_count]

			self.num_walking_frames = 1
		else
			self.num_walking_frames = self.num_walking_frames + 1
		end

		local incs = self.check_for_adjacent_enemies(self, xinc, yinc)

		self.posx = self.posx + incs.x
		self.posy = self.posy + incs.y		

		if (self.posx < 2) then self.posx = 2 end
		if (self.posx + self.width > 126) then self.posx = 126 - self.width end
		if (self.posy < 10) then self.posy = 10 end
		if (self.posy + self.height > 126) then self.posy = 126 - self.height end			

		self.draw_sprite(self)
	end

	enemy.check_for_player = function(self)
		if (not self.dead and is_touching_object(self, self.player)) then
			self.dead = true
			self.player.die(self.player)
		end
	end

	enemy.react_to_bullet = function(self, bullet_direction)
	end

	enemy.check_for_bullets = function(self)
		for bullet in all(bullet_array) do
			if (not self.dead and (bullet ~= nil) and (not bullet.dead)) then
				if bullet.is_touching_object(bullet, self) then
					self.hit_points = self.hit_points - 1

					if (self.hit_points == 0) then
						self.dead = true	
						particle_explosion = new_particle_exp(self.posx + (self.width/2), self.posy + (self.height/2), self.color, self.particle_frame_max, self.num_particles, bullet.direction) 
						add(particle_exp_array, particle_explosion)																							
						uimanager.score += self.points
					else
						self.react_to_bullet(self, bullet.direction)
					end
					
					del(bullet_array, bullet)
				end
			end
		end	
	end

	enemy.check_for_adjacent_enemies = function(self, xinc, yinc)

		local incs = {
			x = xinc,
			y = yinc
		}

		-- Loop through all the enemies, see if we're going to bump into them
		for enemy in all(enemy_array) do					
			if (self.id ~= enemy.id and not enemy.dead) then
				if (xinc == 1 or xinc == -1) then
					if is_next_to_object_x(self, enemy, xinc, yinc) then 						
						incs.x = 0 							
					end
				end

				if (yinc == 1 or yinc == -1) then
					if is_next_to_object_y(self, enemy, xinc, yinc) then 
						incs.y = 0 
					end
				end
			end
		end

		return incs

	end

	return enemy
end