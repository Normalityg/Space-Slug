lifeTime -= 1 * global.delta;
reproTime -= 1 * global.delta;

scorePotential += global.delta * boost;
global.potentialScore += global.delta * boost; // Could have the controller o this * instance_number(grass)

if (lifeTime <= 0){
	if (irandom_range(0,25 / boost) = 0){
		global.potentialScore -= scorePotential;
		scorePotential *= 2; // Double score from this plant
		global.potentialScore += scorePotential;
		sprite_index = spr_flower;
		image_index = irandom_range(0,8);
		lifeTime = irandom_range(20, 40) * boost;
	}
	else instance_destroy();
}
if (reproTime <= 0){
	reproTime = random_range(0,5) / boost;
	instance_create_depth(x + random_range(-12,12),y + random_range(-12,12),0,obj_grass);
}

// Die if the platform is gone
if !(place_meeting(x,y,obj_platform) && place_meeting(x + 3,y,obj_platform) && place_meeting(x + 3,y,obj_platform) && place_meeting(x,y - 1,obj_platform) && place_meeting(x,y + 2,obj_platform))instance_destroy();
// Sway
image_angle = sin((current_time + x + y / 8) / 1000) * 7.5;