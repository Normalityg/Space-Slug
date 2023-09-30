// Movement vectors
var xDist = dcos(dir) * spd * global.delta;
var yDist = -dsin(dir) * spd * global.delta;

// Friction
spd = spd - (spd * 0.5) * global.delta;
if (place_meeting(x,y,obj_platform))spd = spd - (spd * 0.8) * global.delta; // More friction when on platform
else if (point_distance(x,y,obj_player.x,obj_player.y) > 32){ // Solar winds when in space
	// Solar winds
	xDist += (solarWeight) * dcos(global.solarDirection) * global.solarSpeed * global.delta;
	yDist += (solarWeight) * -dsin(global.solarDirection) * global.solarSpeed * global.delta;
	
	// Turn the new location from solar wind into the vector compoenents
	spd = point_distance(x, y, x + (dcos(dir) * spd) + ((solarWeight) * dcos(global.solarDirection) * global.solarSpeed * global.delta), y + (-dsin(dir) * spd) + ((solarWeight) * -dsin(global.solarDirection) * global.solarSpeed * global.delta));
	dir = point_direction(x, y, x + (dcos(dir) * spd) + ((solarWeight) * dcos(global.solarDirection) * global.solarSpeed * global.delta), y + (-dsin(dir) * spd) + ((solarWeight) * -dsin(global.solarDirection) * global.solarSpeed * global.delta));
}
// If there is a collision slow the speed
if (place_meeting(x + xDist, y + yDist, collision)){
	// If a material was hit transfer momentum
	if (place_meeting(x + xDist, y + yDist, obj_material)) instance_place(x + xDist, y + yDist, obj_material).momentum_transfer(self);
	
	// If a printer was hit print
	if (place_meeting(x + xDist, y + yDist, obj_printer)){
		instance_place(x + xDist, y + yDist, obj_printer).print(id);
	}
	
	// If an asteroid was hit try to move it
	if (place_meeting(x + xDist, y + yDist, obj_asteroid)) instance_place(x + xDist, y + yDist, obj_asteroid).momentum_transfer(self);
	
	// If the material has a lot of speed see if its hitting the player
	if (spd > 60 && place_meeting(x + xDist, y + yDist, obj_player)) instance_place(x + xDist, y + yDist, obj_player).momentum_transfer(self);
	spd = (spd / 3) * 2; // Slow the object
}
// X movement
repeat(ceil(abs(xDist))){
	if (abs(xDist) >= 1){
		if (!place_meeting(x + sign(xDist),y,collision))x += sign(xDist);
		xDist -= 1 * sign(xDist);
	}
	else {
		if (!place_meeting(x + xDist,y,collision))x += xDist;
	}
}
// Y movement
repeat(ceil(abs(yDist))){
	if (abs(yDist) >= 1){
		if (!place_meeting(x,y + sign(yDist),collision))y += sign(yDist);
		yDist -= 1 * sign(yDist);
	}
	else {
		if (!place_meeting(x,y + yDist,collision))y += yDist;
	}
}


image_angle += rotateDir * spd * global.delta;

// If the new rotation has collision undo
if (place_meeting(x,y,collision)){
	image_angle -= rotateDir * spd * global.delta;
}
