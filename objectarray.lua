function new_array()

	obj_array = {
		draw = function(self)
			foreach(self, function(obj) obj:draw(obj) end)
		end
	}

	return obj_array
end




