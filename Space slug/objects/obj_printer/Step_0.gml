imageangle = sin(current_time / 500) * 3;

#region Printing

produceTimer -= global.delta;
if (produceTimer < 0 && material >= 33){
	var list = ds_list_create();
	collision_circle_list(x,y,12,obj_platform,true,true,list,false);
	if (ds_list_size(list) < 3){
		material -= 33;
		produceTimer = 0.8;
		produceAnim = new animTracker(0.4);
		shake_camera(6);
	}
	ds_list_destroy(list);
}

if (produceTimer > 0 && produceAnim != -1 && produceAnim.progress() = 1){
	produceAnim = -1;
	repeat(irandom_range(1,1)){
		instance_create_depth(x - 12 + irandom_range(-12,12),y - 12 + irandom_range(-12,12),0,obj_platform);
	}
}

#endregion

#region Particle creation
particleTimer -= 1 * global.delta;
if (particleTimer <= 0){
	particleTimer = 0.2;
	instance_create_depth(x,y,0,obj_homebase_particle);
}
#endregion

#region Movement
// Friction
spd = spd - (spd * 0.8) * global.delta;
if (place_meeting(x,y,obj_platform))spd = spd - (spd * 0.95) * global.delta; // More friction when on platform

// Distances
var xDist = dcos(dir) * spd * global.delta;
var yDist = -dsin(dir) * spd * global.delta;

// If there is a collision slow the speed
if (place_meeting(x + xDist, y + yDist, collision)){
	// If a material was hit transfer momentum
	if (place_meeting(x + xDist, y + yDist, obj_material)) instance_place(x + xDist, y + yDist, obj_material).momentum_transfer(self);
	
	// If the printer was hit try to move it
	if (place_meeting(x + xDist, y + yDist, obj_printer)) instance_place(x + xDist, y + yDist, obj_printer).momentum_transfer(self);
	
	// If an asteroid was hit try to move it
	if (place_meeting(x + xDist, y + yDist, obj_asteroid)) instance_place(x + xDist, y + yDist, obj_asteroid).momentum_transfer(self);
	
	// Print if a material was hit
	if (place_meeting(x + xDist, y + yDist, obj_material))print(instance_place(x + xDist, y + yDist, obj_material));
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
#endregion