function new_gamemanager()
	
	local gamemanager = {
		player = new_player(64,64),
		enemy_array = new_array(),
		bullet_array = new_array(),
		explosion_array = new_array(),
		particle_exp_array = new_array(),		
		enemy_count = 0,
		gamestate = "NEW_LEVEL",
		curlevel = 1,
		level_trans = new_leveltransition(),
		transition_level = function(self)
		end,
		load_level = function(self)
			level = split(levels[self.curlevel])
			
			for xstring in all(level) do
				x = split(xstring, ":")
				if (x[1] == "groff") then
					groff = new_groff(x[2], x[3], self.player)
					add(self.enemy_array, groff)
				elseif(x[1] == "alien") then
					alien = new_alien(x[2], x[3], self.player)
					add(self.enemy_array, alien)
				end
			end	
		end,
		restart_after_death = function(self)
			for enemy in all(self.enemy_array) do
				enemy.posx = enemy.orig_posx
				enemy.posy = enemy.orig_posy
			end
			
			for bullet in all(self.bullet_array) do del(self.bullet_array, bullet) end
			for exp in all(self.explosion_array) do del(self.explosion_array, exp) end
		end,
		update = function(self)
			if (self.gamestate == "NEW_LEVEL") then
				self.player.reset(self.player)
				self.load_level(self)
				self.gamestate = "PLAYING"
			elseif (self.gamestate == "PLAYER_DEAD") then
				self.player.dead = false
				self.player.reset(self.player)
				
				if (uimanager.players > 0) then
					uimanager.players -= 1
					self.restart_after_death(self)
					self.gamestate = "PLAYING"
				else
					self.gamestate = "GAME_OVER"
				end
			elseif (count(self.enemy_array) == 0 and self.gamestate ~= "TRANSITION") then
				self.gamestate = "TRANSITION"
				self.curlevel += 1
			elseif ((self.gamestate == "TRANSITION") and (self.level_trans.status == 3)) then
				self.gamestate = "NEW_LEVEL"
			elseif (self.gamestate == "GAME_OVER") then		
			end
			
			self.player.update(self.player)
		
			cleanup_array(self.enemy_array)
			cleanup_array(self.bullet_array)
			cleanup_array(self.explosion_array)
		
		end,
		draw = function(self)
			cls(0)					
			
			if (self.gamestate == "TRANSITION") then
				if (self.level_trans.status ~= 3) then					
					self.level_trans.draw(self.level_trans)
				end
			else
				self.player.draw(self.player)
				
				if (not self.player.dead) then		
					self.bullet_array.draw(self.bullet_array)
					self.enemy_array.draw(self.enemy_array)
					self.explosion_array.draw(self.explosion_array)
					self.particle_exp_array.draw(self.particle_exp_array)		
				end				
			end
		
			uimanager.draw(uimanager)
			map(0, 0, 0, 0, 128, 32)
		end
	}
	
	return gamemanager
	
end