imageangle += 13 * global.delta;//sin(current_time / 6000) * 30;

if (hitTimer > 0)hitTimer -= 1;

#region Particle creation
particleTimer -= 1 * global.delta;
if (particleTimer <= 0){
	particleTimer = 1 / materials;
	instance_create_depth(x,y,0,obj_node_particle);
}
#endregion