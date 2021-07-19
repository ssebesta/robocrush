function new_explosion(x, y, size)

	local _num_frames = 3
	local _spr_array

	if (size == 1) then
		_num_frames = 3
		_spr_array = { 11, 12, 13 }
	end

	local explosion = new_sprite(x, y)

	explosion.posx = x
	explosion.posy = y
	explosion.frame_num = 1
	explosion.num_frames = _num_frames
	explosion.spr_array = _spr_array
	explosion.dead = false
	explosion.draw = 
	function(self)
		if (self.frame_num <= self.num_frames) then
			spr(self.spr_array[self.frame_num], self.posx, self.posy)
			self.frame_num += 1
		else
			self.dead = true
			del(explosion_array, self)
		end

	end

	return explosion

end