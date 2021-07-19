function new_groff(x,y, _player)

	local groff = new_enemy(x, y, 8, 8, 8, 1, _player)

	groff.frames_per_move = 4
	groff.num_walking_frames = 4
	groff.spr_num_array = { 9, 10 }
	groff.spr_num_count = 1
	groff.num_sprites_x = 1
	groff.num_sprites_y = 1	
	groff.particle_frame_max = 10
	groff.color = 8
	groff.points = 100

	groff.draw = function(self)	

		self.check_for_bullets(self)

		self.check_for_player(self)

		if (not self.dead) then				
			self.move_toward_player(self)
		end

	end	

	return groff

end





