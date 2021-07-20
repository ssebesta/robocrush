function is_next_to_object_x(obj1, obj2, xdir, ydir)
	local retval = false
	local obj1left = obj1.posx + xdir
	local obj1right = obj1.posx + obj1.width - 1 + xdir
	local obj1top = obj1.posy + ydir
	local obj1bottom = obj1.posy + obj1.height - 1 + ydir	
	local obj2left = obj2.posx
	local obj2right = obj2.posx + obj2.width - 1
	local obj2top = obj2.posy
	local obj2bottom = obj2.posy + obj2.height - 1
	
	if (xdir == 1) then		
		if ((obj1right >= obj2left) and 
			(obj1right <= obj2right) and 
			(obj1bottom > obj2top) and 
			(obj1top < obj2bottom)) then 
			retval = true 
		end

	elseif (xdir == -1) then		
		if ((obj1left <= obj2right) and 
			(obj1left >= obj2left) and
			(obj1bottom > obj2top) and 
			(obj1top < obj2bottom)) then 
			retval = true
		end
	end

	return retval
end

function is_next_to_object_y(obj1, obj2, xdir, ydir)
	local retval = false
	local obj1left = obj1.posx + xdir
	local obj1right = obj1.posx + obj1.width - 1 + xdir
	local obj1top = obj1.posy + ydir
	local obj1bottom = obj1.posy + obj1.height - 1 + ydir	
	local obj2left = obj2.posx
	local obj2right = obj2.posx + obj2.width - 1
	local obj2top = obj2.posy
	local obj2bottom = obj2.posy + obj2.height - 1

	if (ydir == 1) then		
		if ((obj1bottom >= obj2top) and
			(obj1bottom <= obj2bottom) and
			(obj1right >= obj2left) and
			(obj1left <= obj2right)) then
			retval = true
		end
	elseif (ydir == -1) then		
		if ((obj1top <= obj2bottom) and
			(obj1top >= obj2top) and
			(obj1right >= obj2left) and
			(obj1left <= obj2right)) then
			retval = true
		end
	end

	return retval
end

function is_touching_object(obj1, obj2)
	local retval = false
	local obj1left = obj1.posx
	local obj1right = obj1.posx + obj1.width - 1
	local obj1top = obj1.posy
	local obj1bottom = obj1.posy + obj1.height - 1	
	local obj2left = obj2.posx
	local obj2right = obj2.posx + obj2.width - 1
	local obj2top = obj2.posy
	local obj2bottom = obj2.posy + obj2.height - 1


	if ((obj1right >= obj2left) and (obj1left <= obj2right) and (obj1bottom >= obj2top) and (obj1top <= obj2bottom)) then
		retval = true
	end

	return retval
end

function cleanup_array(array)
	for obj in all(array) do	
		if (obj.dead) then 			
			del(array, obj)
			obj = nil
		end
	end
end

