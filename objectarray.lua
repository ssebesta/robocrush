function new_array()	

	obj_array = {
		draw = function(self)
			foreach(self, function(obj) obj:draw(obj) end)
		end,
		alldead = function(self)
			dead = true
			for obj in all(self) do
				if (not obj.dead) then dead = false end
			end

			return dead
		end
	}

	return obj_array
end




