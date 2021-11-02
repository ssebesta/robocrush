function new_tankbot(x,y, _player)

	local tankbot = new_enemy(x, y, 8, 8, 25, 1, _player)

	tankbot.frames_per_move = 4
	tankbot.num_walking_frames = 4
	tankbot.spr_num_array = { 25, 26 }
	tankbot.spr_num_count = 1
	tankbot.num_sprites_x = 1
	tankbot.num_sprites_y = 1	
	tankbot.particle_frame_max = 10
	tankbot.hit_points = 3
	tankbot.color = 4
	tankbot.points = 200

	tankbot.draw = function(self)	

		self.check_for_bullets(self)

		self.check_for_player(self)

		if (not self.dead) then				
			self.move_toward_player(self)
		end

	end	

	return tankbot

end