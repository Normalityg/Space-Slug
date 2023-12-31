imageangle = 0;
particleTimer = 0;

dir = 0;
spd = 0;

momentum_transfer = function(_hitter){
	// Exit if not enough spd
	if (_hitter.spd < 40)return;
	
	// Ratio for how much to change the angle
	var ratio = 0;
	if (_hitter.spd > spd)ratio = abs(spd) / (abs(spd) + abs(_hitter.spd));
	else ratio = abs(_hitter.spd) / (abs(spd) + abs(_hitter.spd));
	
	// Change the direction
	dir += angle_difference(_hitter.dir, dir) * ratio;
	
	// Take some of the speed
	spd += _hitter.spd * 0.3;
}