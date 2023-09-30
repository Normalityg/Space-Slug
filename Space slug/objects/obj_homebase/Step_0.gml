imageangle = sin(current_time / 500) * 3;

if (place_meeting(x,y,obj_platform))instance_place(x,y,obj_platform).powered = true

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
	if (place_meeting(x + xDist, y + yDist, obj_material)){
		var material = instance_place(x + xDist, y + yDist, obj_material);
		// Ratio for how much to change the angle
		var ratio = 0;
		if (spd > material.spd)ratio = (material.spd / (spd + material.spd));
		else ratio = spd / (material.spd + spd);
		
		material.dir += angle_difference(dir,material.dir) * ratio;
		show_debug_message(ratio);
		material.spd += spd * 0.3;
	}
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