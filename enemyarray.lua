enemy_array = {
	draw = function(self)
		for enemy in all(self) do
			enemy.draw(enemy)
		end
	end
}