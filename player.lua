function new_player(x,y)

	local player = new_sprite(x, y, 8, 8, 1)

	player.dying_spr_num = 14
	player.num_walking_frames = 1
	player.num_firing_frames = 1
	player.frames_per_bullet = 8
	player.dying_frames_counter = 1
	player.num_dying_frames = 4
	player.dying_spr_array = { 14, 15 }
	player.dying_spr_num = 1
	player.aim_direction = 4
	player.is_firing = false
	player.is_walking = false
	player.draw = 
	function(self)
		if (not self.dead) then
			if (self.is_walking) then			
				if (self.num_walking_frames == 2) then
					if (self.spr_num == 2) then self.spr_num = 3 else self.spr_num = 2 end
					self.num_walking_frames = 1
				else
					self.num_walking_frames = 2
				end
			else
				self.spr_num = 1
			end
			spr(self.spr_num, self.posx, self.posy)
		else
			if (self.dying_frames_counter == self.num_dying_frames) then
				self.dying_frames_counter = 1
				if (self.dying_spr_num < count(self.dying_spr_array)) then self.dying_spr_num += 1 else self.dying_spr_num = 1 end
			else
				self.dying_frames_counter += 1
			end

			spr(self.dying_spr_array[self.dying_spr_num], self.posx, self.posy)
		end
	end
	player.update =
	function(self)		
		if (not self.dead) then
			self.is_walking = false		
			local _aim_direction = self.aim_direction	

			if (btn(0)) then self.posx -= 1 self.is_walking = true _aim_direction = 4 end -- left
			if (btn(1)) then self.posx += 1 self.is_walking = true _aim_direction = 6 end -- right
			if (btn(2)) then self.posy -= 1 self.is_walking = true _aim_direction = 8 end -- up
			if (btn(3)) then self.posy += 1 self.is_walking = true _aim_direction = 2 end -- down

			if (self.posx < 1) then self.posx = 1 end
			if (self.posx + self.width > 127) then self.posx = 127 - self.width end
			if (self.posy < 10) then self.posy = 10 end
			if (self.posy + self.height > 126) then self.posy = 126 - self.height end

			if (btn(0) and btn(2)) then _aim_direction = 7 end
			if (btn(0) and btn(3)) then _aim_direction = 1 end
			if (btn(1) and btn(2)) then _aim_direction = 9 end
			if (btn(1) and btn(3)) then _aim_direction = 3 end

			bullet = nil

			if (btn(4)) then	
				if (not self.is_firing) then							
					self.aim_direction = _aim_direction		
					self.num_firing_frames = self.frames_per_bullet					
				end

				if (self.num_firing_frames == self.frames_per_bullet) then
					bullet = new_bullet(self.posx, self.posy, self.aim_direction)
					add(bullet_array, bullet)
					self.num_firing_frames = 1
				else
					self.num_firing_frames += 1
				end

				self.is_firing = true;	
			else
				self.is_firing = false
			end
		end
	end
	player.die = function(self)
		self.dead = true			
	end
	
	return player

end
