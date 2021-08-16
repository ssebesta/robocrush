function new_leveltransition()
	
	trans = {
		draw_cnt_max = 30,
		draw_cnt = 1,
		draw_freq = 1, 
		draw_freq_cnt = 1,
		orig_posx = 63,
		orig_posy = 63,
		y = 2,
		x = 2,
		status = 1,
		draw = function(self)
			y = 2
			x = 2
		
			if (self.x <= 65) then
				while x <= self.x do				
					pset(self.orig_posx - x, self.orig_posy, 10) -- left
					if (self.orig_posy - y > 10) then
						pset(self.orig_posx - x, self.orig_posy - y, 10) -- upper left						
					end
					if (self.orig_posy - y > 10) then
						pset(self.orig_posx, self.orig_posy - y, 10) -- up
					end
					if (self.orig_posy - y > 10) then
						pset(self.orig_posx + x, self.orig_posy - y, 10) -- upper right
					end
					pset(self.orig_posx + x, self.orig_posy, 10) -- right
					pset(self.orig_posx + x, self.orig_posy + y, 10) -- lower right
					pset(self.orig_posx, self.orig_posy + y, 10) -- down
					pset(self.orig_posx - x, self.orig_posy + y, 10) -- lower left						
					
					x += 2
					y += 2				
		
				end
								
				self.y += 2
				self.x += 2	
				
			else
				if (self.status == 1) then
					self.status = 3
				else
					self.status = 3			
				end				
			end
			
		end,			
		draw_ = function(self)
			x = 2
			y = 2
			i = 0

			if (self.draw_cnt < self.draw_cnt_max) then
				while i < self.draw_cnt do					
					pset(self.orig_posx - x, self.orig_posy, 10) -- left
					if (self.orig_posy - y > 10) then
						pset(self.orig_posx - x, self.orig_posy - y, 10) -- upper left						
					end
					if (self.orig_posy - y > 10) then
						pset(self.orig_posx, self.orig_posy - y, 10) -- up
					end
					if (self.orig_posy - y > 10) then
						pset(self.orig_posx + x, self.orig_posy - y, 10) -- upper right
					end
					pset(self.orig_posx + x, self.orig_posy, 10) -- right
					pset(self.orig_posx + x, self.orig_posy + y, 10) -- lower right
					pset(self.orig_posx, self.orig_posy + y, 10) -- down
					pset(self.orig_posx - x, self.orig_posy + y, 10) -- lower left
					
					if (self.orig_posy + y >= 126 and not self.reverse) then self.reverse = true end							
				
					y += 2
					x += 2
					i += 1
					
					if (self.draw_freq_cnt == self.draw_freq) then
						self.draw_freq_cnt = 1
						self.draw_cnt += 1
					else
						self.draw_freq_cnt += 1
					end
	
				end
			
			elseif (self.status == 1) then
				self.status = 2
			else
				self.status = 3			
			end
			
		end				
	}
	
	return trans
	
end