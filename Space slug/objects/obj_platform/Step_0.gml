if (hp < 0){
	repeat(irandom_range(4,7))instance_create_depth(x + random(24),y + random(24),0,obj_platform_particle);
	shake_camera(3 * dropoff);
	instance_destroy();
}