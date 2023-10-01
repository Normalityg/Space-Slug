if (!activated)if (instance_exists(obj_player) && point_distance(x,y,obj_player.x,obj_player.y) < 600)activated = true;
if (activated){
	imageangle += 13 * global.delta;//sin(current_time / 6000) * 30;
	
	if (hitTimer > 0)hitTimer -= 1;
	
	if (irandom_range(0,game_get_speed(gamespeed_fps) * 30) = 0 && materials < 4){
		image_index = 0;
		materials += 1;
	}
	
	#region Particle creation
	particleTimer -= 1 * global.delta;
	if (particleTimer <= 0){
		particleTimer = 1 / materials;
		instance_create_depth(x,y,0,obj_node_particle);
	}
	#endregion
}