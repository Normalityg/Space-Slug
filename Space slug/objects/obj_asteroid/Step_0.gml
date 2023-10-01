#region Splitting

if (spd > 1000){
	//sprite_index = spr_grass;
	var w = sprite_width / 2;
	var h = sprite_height / 2;
	sprite_index = -1;
	repeat(3){
		var iterations = 0;
		var success = false;
		while (iterations < 100 && !success){
			iterations ++;
			
			var child = instance_create_depth(x + random_range(-w,w),y + random_range(h,h),0,obj_asteroid);

			
			child.parent = self;
			
			with(child){
				if (!place_meeting(x,y,collision)){
					size = parent.size - 1;
					spdMax = parent.spdMax * 2;
					if (size = 1)sprite_index = spr_asteroid_medium;
					if (size = 0)sprite_index = spr_asteroid_tiny;
					if (child.size = -1)instance_destroy();
				}
				else instance_destroy(child);
			}
			
			if (instance_exists(child))success = true;

			
		}
	}
	instance_destroy();
}

#endregion

#region Movement

// Movement vectors
var xDist = dcos(dir) * spd * global.delta;
var yDist = -dsin(dir) * spd * global.delta;

// Solar winds
xDist += (solarWeight * size * 0.2) * dcos(global.solarDirection) * global.solarSpeed * global.delta;
yDist += (solarWeight * size * 0.2) * -dsin(global.solarDirection) * global.solarSpeed * global.delta;

// Turn the new location from solar wind into the vector compoenents
spd = point_distance(x, y, x + (dcos(dir) * spd) + ((solarWeight * (1 + size * 0.2)) * dcos(global.solarDirection) * global.solarSpeed * global.delta), y + (-dsin(dir) * spd) + ((solarWeight * (1 + size * 0.2)) * -dsin(global.solarDirection) * global.solarSpeed * global.delta));
dir = point_direction(x, y, x + (dcos(dir) * spd) + ((solarWeight * (1 + size * 0.2)) * dcos(global.solarDirection) * global.solarSpeed * global.delta), y + (-dsin(dir) * spd) + ((solarWeight * (1 + size * 0.2)) * -dsin(global.solarDirection) * global.solarSpeed * global.delta));

// Friction
spd = spd - (spd * 0.5) * global.delta;
if (place_meeting(x,y,obj_platform))spd = spd - (spd * 0.8) * global.delta; // More friction when on platform

// If there is a collision slow the speed
if (place_meeting(x + xDist, y + yDist, [obj_player,obj_printer,obj_asteroid,obj_material,obj_wall,obj_platform])){
	// If a material was hit transfer momentum
	if (place_meeting(x + xDist, y + yDist, obj_material)) instance_place(x + xDist, y + yDist, obj_material).momentum_transfer(self);
	
	// If the printer was hit try to move it
	if (place_meeting(x + xDist, y + yDist, obj_printer)) instance_place(x + xDist, y + yDist, obj_printer).momentum_transfer(self);
	
	// If an asteroid was hit try to move it
	if (place_meeting(x + xDist, y + yDist, obj_asteroid)) instance_place(x + xDist, y + yDist, obj_asteroid).momentum_transfer(self);
	
	// If the player was hit try to move it
	if (place_meeting(x + xDist, y + yDist, obj_player)) instance_place(x + xDist, y + yDist, obj_player).momentum_transfer(self);
	
	// If a platform is hit and the asteroid has speed damage it
	if (spd > 8 && place_meeting(x + xDist, y + yDist, obj_platform)) instance_place(x + xDist, y + yDist, obj_platform).hp -= log2(spd) * (size + 1);
	
	spd = (spd / 4) * 3; // Slow the object
}
// X movement
repeat(ceil(abs(xDist))){
	if (abs(xDist) >= 1){
		if (!place_meeting(x + sign(xDist),y,[obj_player,obj_printer,obj_asteroid,obj_material,obj_wall,obj_platform]))x += sign(xDist);
		xDist -= 1 * sign(xDist);
	}
	else {
		if (!place_meeting(x + xDist,y,[obj_player,obj_printer,obj_asteroid,obj_material,obj_wall,obj_platform]))x += xDist;
	}
}
// Y movement
repeat(ceil(abs(yDist))){
	if (abs(yDist) >= 1){
		if (!place_meeting(x,y + sign(yDist),[obj_player,obj_printer,obj_asteroid,obj_material,obj_wall,obj_platform]))y += sign(yDist);
		yDist -= 1 * sign(yDist);
	}
	else {
		if (!place_meeting(x,y + yDist,[obj_player,obj_printer,obj_asteroid,obj_material,obj_wall,obj_platform]))y += yDist;
	}
}


image_angle += rotateDir * spd * global.delta;

// If the new rotation has collision undo
if (place_meeting(x,y,[obj_player,obj_printer,obj_asteroid,obj_material,obj_wall,obj_platform])){
	image_angle -= rotateDir * spd * global.delta;
}

#endregion

age += global.delta;
if (age > 30)instance_destroy();