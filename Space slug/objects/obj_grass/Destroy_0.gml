global.potentialScore -= scorePotential;
if (scorePotential != 0){
	repeat(irandom_range(1,3))instance_create_depth(x + irandom_range(-1,2), y + irandom_range(-3,-1),0,obj_grass_particle);
	audio_play_sound(snd_grass1,0,false,1 - point_distance(x,y,camera.x,camera.y) / 400);
}