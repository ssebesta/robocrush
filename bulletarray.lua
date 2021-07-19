bullet_array = {
	draw = function(self)
		foreach(self, function(bullet) bullet:draw(bullet) end)
	end
}