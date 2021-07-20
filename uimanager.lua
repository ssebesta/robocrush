function format_number(num)

	x = tostr(num)

	while(#x < 10) x = '0'..x

	return x

end

function new_uimanager()

	local uimanager = {
		score = 0,
		players = 3,
		
		draw = function(self)

			-- Update players remaining
			for i=0, self.players-1 do
				spr(24, i * 8, 0)
			end

			-- Update score
			print(format_number(self.score), 45, 0, 7)
		end		
	}

	return uimanager

end