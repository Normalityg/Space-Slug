imageangle = 0;
particleTimer = 0;

dir = 0;
spd = 0;

material = 0;
materialMax = 165;

produceTimer = 0;
produceAnim = -1;

soundAnim = new animTracker(0.05);

print = function(_material){
	var maxMaterial = min(_material.material, materialMax - material) // The most material the printer can get from the interaction
	
	material += maxMaterial;
	_material.material -= maxMaterial;
	
	if (_material.material <= 0)instance_destroy(_material);
}

momentum_transfer = function(_hitter){
	// Exit if not enough spd
	if (abs(_hitter.spd) < 5)return;
	
	// Ratio for how much to change the angle
	var ratio = 0;
	if (abs(_hitter.spd) > spd)ratio = abs(spd) / (abs(spd) + abs(_hitter.spd));
	else ratio = abs(_hitter.spd) / (abs(spd) + abs(_hitter.spd));
	
	// Change the direction
	dir += angle_difference(_hitter.dir, dir) * ratio;
	
	// Take some of the speed
	spd += _hitter.spd * 0.15;
	
	if (_hitter.spd * 0.15 > 5 && soundAnim.progress() = 1){
		soundAnim = new animTracker(0.05);
		audio_play_sound(snd_hit2,0,false,dropoff,0.1);
	}
}