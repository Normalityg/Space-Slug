image_angle = irandom_range(0,360);
rotateDir = choose(-1,1);

spd = 0;
dir = 0;

solarWeight = random_range(0.05,0.3);

material = 99;

alarm[0] = 1;

soundAnim = new animTracker(0.05);

momentum_transfer = function(_hitter){
	// Ratio for how much to change the angle
	var ratio = 0;
	if (_hitter.spd > spd)ratio = abs(spd) / (abs(spd) + abs(_hitter.spd));
	else ratio = abs(_hitter.spd) / (abs(spd) + abs(_hitter.spd));
	
	// Change the direction
	dir += angle_difference(_hitter.dir, dir) * ratio;
	
	// Take some of the speed
	spd += _hitter.spd * 0.3;
	
	if (_hitter.spd * 0.15 > 2 && soundAnim.progress() = 1){
		soundAnime= new animTracker(0.1);
		audio_play_sound(snd_hit2,0,false,dropoff,0.1);
	}
}

if (room = rm_main_menu)instance_destroy(); // Dont exist in non game rooms