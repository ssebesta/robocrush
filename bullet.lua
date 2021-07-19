-- _direction:
-- 7 8 9
-- 4   6
-- 1 2 3

function new_bullet(x, y, _direction)

	local _spr_num = 4
	local _xinc = 0
	local _yinc = 0
	local _speed = 4
	local _xoffset = 4
	local _yoffset = 4
	local _pointx = 0
	local _pointy = 0

	if (_direction == 7) then 
		_spr_num = 7 
		_xinc = -1
		_yinc = -1
		_xoffset = -_xoffset
		_yoffset = -_yoffset 
	elseif (_direction == 3) then 
		_spr_num = 7
		_xinc = 1
		_yinc = 1
		_pointx = 8
		_pointy = 8
	elseif (_direction == 9) then
		_spr_num = 6
		_xinc = 1
		_yinc = -1
		_yoffset = -_yoffset 
		_pointx = 8
	elseif (_direction == 1) then 
		_spr_num = 6
		_xinc = -1
		_yinc = 1
		_xoffset = -_xoffset
		_pointy = 8
	elseif (_direction == 8) then
		_spr_num = 5
		_xinc = 0
		_yinc = -1
		_yoffset = -_yoffset 
		_xoffset = 0
		_pointx = 5
	elseif (_direction == 2) then 
		_spr_num = 5 
		_xinc = 0
		_yinc = 1
		_xoffset = 0
		_pointx = 5
		_pointy = 8
	elseif (_direction == 4) then 
		_spr_num = 4
		_xinc = -1
		_yinc = 0
		_xoffset = -_xoffset
		_yoffset = 0
		_pointy = 5
	elseif (_direction == 6) then 
		_spr_num = 4
		_xinc = 1
		_yinc = 0
		_yoffset = 0
		_pointx = 8
		_pointy = 5
	end

	_xinc = _xinc * _speed
	_yinc = _yinc * _speed

	local bullet = new_sprite(x, y, 8, 8, _spr_num)

	bullet.posx = x + _xoffset
	bullet.posy = y + _yoffset
	bullet.xinc = _xinc
	bullet.yinc = _yinc
	bullet.pointx = _pointx
	bullet.pointy = _pointy
	bullet.direction = _direction
	bullet.draw = function(self)
		if (not self.dead) then			
			self.posx = self.posx + self.xinc
			self.posy = self.posy + self.yinc

			spr(self.spr_num, self.posx, self.posy)
		end
	end
	bullet.is_touching_object = function(self, obj2)
		retval = false

		local obj2left = obj2.posx
		local obj2right = obj2.posx + obj2.width - 1
		local obj2top = obj2.posy
		local obj2bottom = obj2.posy + obj2.height - 1

		if (((self.pointx + self.posx) >= obj2left) and ((self.pointx + self.posx) <= obj2right) and ((self.pointy + self.posy) >= obj2top) and ((self.pointy + self.posy) <= obj2bottom)) then
			retval = true
		end		

		return retval	
	end
	
	return bullet
end