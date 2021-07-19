-- Bullet directions:
-- 7 8 9
-- 4   6
-- 1 2 3

function new_particle_exp(x, y, _color, _frame_max, _num_particles, bullet_dir)

	local exp = {
		particles = {},
		draw = function(self)
			for particle in all(self.particles) do
				particle.draw(particle)
			end			
		end
	}

	for i=0, (_num_particles - 1) do		

		if (bullet_dir == 7 or bullet_dir == 4 or bullet_dir == 1) then
			_xinc = -flr(rnd(6))
		elseif (bullet_dir == 9 or bullet_dir == 6 or bullet_dir == 3) then
			_xinc = flr(rnd(6))
		else
			_xinc = flr(rnd(8) - 4)
		end

		if (bullet_dir == 7 or bullet_dir == 8 or bullet_dir == 9) then
			_yinc = -flr(rnd(6))
		elseif (bullet_dir == 1 or bullet_dir == 2 or bullet_dir == 3) then
			_yinc = flr(rnd(6))
		else
			_yinc = flr(rnd(8) - 4)
		end

		-- We don't want any particles to just sit still
		if (_xinc ~= 0 or _yinc ~= 0) then

			local particle = {
				xinc = _xinc,
				yinc = _yinc,
				radius = _radius,
				xpos = x,
				ypos = y,	
				color = _color,		
				frame_cnt = 0,
				frame_max = _frame_max,
				draw = function(self)
					if (self.frame_cnt == self.frame_max) then
					else
						self.xpos = self.xpos + self.xinc
						self.ypos = self.ypos + self.yinc

						pset(self.xpos, self.ypos, _color)
						self.frame_cnt += 1
					end

				end
			}

			add(exp.particles, particle)
		end

	end	

	return exp
end