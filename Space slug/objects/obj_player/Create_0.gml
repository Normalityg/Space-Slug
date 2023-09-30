
dir = 0;
spd = 0;

dirKB = 0;
spdKB = 0;

hp = 30;
hpMax = 30;
hpRecovery = 0.4;
hpLoss = 1;

respawning = false;
respawnTimer = 0;

momentum_transfer = function(_hitter){
	//var xDist = dcos(dir) * spd * global.delta;
	//var yDist = -dsin(dir) * spd * global.delta;
	//
	//// Solar winds
	//xDist += solarWeight * dcos(global.solarDirection) * global.solarSpeed * global.delta;
	//yDist += solarWeight * -dsin(global.solarDirection) * global.solarSpeed * global.delta;
	//
	//// Turn the new location from solar wind into the vector compoenents
	//spd = point_distance(x, y, x + (dcos(dir) * spd) + (dcos(global.solarDirection) * global.solarSpeed * global.delta), y + (-dsin(dir) * spd) + (-dsin(global.solarDirection) * global.solarSpeed * global.delta));
	//dir = point_direction(x, y, x + (dcos(dir) * spd) + (dcos(global.solarDirection) * global.solarSpeed * global.delta), y + (-dsin(dir) * spd) + (-dsin(global.solarDirection) * global.solarSpeed * global.delta));
		// Ratio for how much to change the angle
	var ratio = 0;
	if (_hitter.spd > spdKB)ratio = abs(spdKB) / (abs(spdKB) + abs(_hitter.spd));
	else ratio = abs(_hitter.spd) / (abs(spdKB) + abs(_hitter.spd));
	
	// Change the direction
	dirKB += angle_difference(_hitter.dir, dirKB);
	
	// Take some of the speed
	spdKB += _hitter.spd * 0.3;
}