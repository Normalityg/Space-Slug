image_angle = irandom_range(0,360);
rotateDir = choose(-1,1);

spd = 0;
dir = 0;

solarWeight = random_range(0.05,0.3);

material = 99;

momentum_transfer = function(_hitter){
	// Ratio for how much to change the angle
	var ratio = 0;
	if (_hitter.spd > spd)ratio = abs(spd) / (abs(spd) + abs(_hitter.spd));
	else ratio = abs(_hitter.spd) / (abs(spd) + abs(_hitter.spd));
	
	// Change the direction
	dir += angle_difference(_hitter.dir, dir) * ratio;
	
	// Take some of the speed
	spd += _hitter.spd * 0.3;
	
}