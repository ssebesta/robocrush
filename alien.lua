function new_alien(x,y, _player)

	local alien = new_enemy(x, y, 16, 16, 16, 1, _player)

	alien.frames_per_move = 6
	alien.num_walking_frames = 6
	alien.spr_num_array = { 16, 18, 20, 22 }
	alien.spr_num_count = 1
	alien.num_sprites_x = 2
	alien.num_sprites_y = 2
	alien.hit_points = 5
	alien.particle_frame_max = 30
	alien.color = 3
	alien.points = 500

	alien.react_to_bullet = function(self, bullet_direction)
		local xinc = 0
		local yinc = 0
		if (bullet_direction == 7 or bullet_direction == 4 or bullet_direction == 1) then
			xinc = -1
		elseif (bullet_direction == 9 or bullet_direction == 6 or bullet_direction == 3) then
			xinc = 1
		end

		if (bullet_direction == 7 or bullet_direction == 8 or bullet_direction == 9) then
			yinc = -1
		elseif (bullet_direction == 1 or bullet_direction == 2 or bullet_direction == 3) then
			yinc = 1
		end

		self.posx = self.posx + xinc
		self.posy = self.posy + yinc
	end	

	alien.draw = function(self)	

		self.check_for_bullets(self)

		self.check_for_player(self)

		if (not self.dead) then				
			self.move_toward_player(self)
		end
		
	end	

	return alien

end