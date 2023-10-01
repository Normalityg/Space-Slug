var keyLeft = keyboard_check(ord("A"));
var keyRight = keyboard_check(ord("D"));
var keyForward = keyboard_check(ord("W"));
var keyBackward = keyboard_check(ord("S"));

if (mouse_check_button_pressed(mb_left))shake_camera(4);

#region Movement

// Friction
spd = spd - (spd * 0.2) * global.delta;
if (place_meeting(x,y,obj_platform))spd = spd - (spd * 0.7) * global.delta; // More friction when on platform

// Knockback friction
spdKB = spdKB - (spdKB * 0.7) * global.delta;
if (place_meeting(x,y,obj_platform))spdKB = spdKB - (spdKB * 0.98) * global.delta; // More friction when on platform

// Turning
var dirChange = (keyLeft - keyRight) * 4;
dir += dirChange;

// Increase the speed based on how fast they are going (faster = less accel)
spd += (((keyForward - keyBackward) * 128) / (1 + abs(spd) / 64)) * global.delta;

var xDist = dcos(dir) * spd * global.delta + dcos(dirKB) * spdKB * global.delta;
var yDist = -dsin(dir) * spd * global.delta + -dsin(dirKB) * spdKB * global.delta;

// If there is a collision slow the speed
if (place_meeting(x + xDist, y + yDist, collision)){
	
	// If a node was hit make it spew
	if (place_meeting(x + xDist, y + yDist, obj_node)){
		instance_place(x + xDist, y + yDist, obj_node).spew(self);
	}
	// If a material was hit transfer momentum
	if (place_meeting(x + xDist, y + yDist, obj_material)) instance_place(x + xDist, y + yDist, obj_material).momentum_transfer(self);
	
	// If the printer was hit try to move it
	if (place_meeting(x + xDist, y + yDist, obj_printer)) instance_place(x + xDist, y + yDist, obj_printer).momentum_transfer(self);
	
	// If an asteroid was hit try to move it
	if (place_meeting(x + xDist, y + yDist, obj_asteroid)) instance_place(x + xDist, y + yDist, obj_asteroid).momentum_transfer(self);
	
	spd = (spd / 4) * 3; // Slow the player
	spdKB = 0;
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


image_angle = dir;

// If the new rotation has collision undo
if (place_meeting(x,y,collision)){
	dir -= dirChange;
	image_angle = dir;
}

#endregion