imageangle = 0;

particleTimer = 0;

materials = irandom_range(3,9);

hitTimer = 5;
spew = function(_hitter){
	if (hitTimer != 0 || materials = 0)return;
	if (abs(_hitter.spd) > 32){
		hitTimer = 10;
		shake_camera(4,point_direction(_hitter.x, _hitter.y, _hitter.x + dcos(_hitter.dir) * _hitter.spd * global.delta, _hitter.y - dsin(_hitter.dir) * _hitter.spd * global.delta));
		repeat(irandom_range(4,7)){
			var part = instance_create_depth(x,y,0,obj_node_particle);
			part.direction = point_direction(_hitter.x, _hitter.y, _hitter.x + dcos(_hitter.dir) * _hitter.spd * global.delta, _hitter.y - dsin(_hitter.dir) * _hitter.spd * global.delta) + random_range(-15, 15);
			part.speed = random_range(0.2,1);
		}
		var material = instance_create_depth(x,y,0,obj_material);
		material.dir = point_direction(_hitter.x, _hitter.y, _hitter.x + dcos(_hitter.dir) * _hitter.spd * global.delta, _hitter.y - dsin(_hitter.dir) * _hitter.spd * global.delta) + random_range(-15, 15);
		material.spd = irandom_range(16,_hitter.spd);
		material.x = material.x + dcos(material.dir) * 16;
		material.y = material.y - dsin(material.dir) * 16;
		
		materials --;
		if (materials = 0)image_index = 1;
		
		audio_play_sound(snd_grass1,0,false,1 - point_distance(x,y,camera.x,camera.y) / 400);
	}
}