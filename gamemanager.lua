function new_gamemanager()
	
	local gamemanager = {
		player = new_player(64,64),
		enemy_array = new_array(),
		bullet_array = new_array(),
		explosion_array = new_array(),
		particle_exp_array = new_array(),
		uimanager = new_uimanager(),
		draw = function(self)
			
		end,
		load_level = function(self)
			level = split(levels[curlevel])
			
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
			if (gamestate == "NEW_LEVEL") then
				self.load_level()
				gamestate = "PLAYING"
			elseif (gamestate == "PLAYER_DEAD") then
				self.player.dead = false
				self.player.posx = self.player.orig_posx
				self.player.posy = self.player.orig_posy
				
				if (self.uimanager.players > 0) then
					self.uimanager.players -= 1
					self.restart_after_death()
					gamestate = "PLAYING"
				else
					gamestate = "GAME_OVER"
				end
			elseif (count(self.enemy_array) == 0) then
				gamestate = "NEW_LEVEL"
				curlevel += 1
			elseif (gamestate == "GAME_OVER") then		
			end
			
			self.player.update(self.player)
		
			cleanup_array(self.enemy_array)
			cleanup_array(self.bullet_array)
			cleanup_array(self.explosion_array)
		
		end,
		draw = function(self)
			cls(0)
		
			self.player.draw(player)
		
			if (not self.player.dead) then		
				self.bullet_array.draw(self.bullet_array)
				self.enemy_array.draw(self.enemy_array)
				self.explosion_array.draw(self.explosion_array)
				self.particle_exp_array.draw(self.particle_exp_array)		
			end
		
			self.uimanager.draw(self.uimanager)
			map(0, 0, 0, 0, 128, 32)
		end
	}
	
	return gamemanager
	
end