size = 2; // 0 = small 1 = medium 2 = large
image_index = irandom_range(0,image_number);

image_angle = irandom_range(0,360);
rotateDir = choose(-1,1);

spd = 10;
spdMax = 20;
dir = 0;

age = 0;

solarWeight = random_range(0.7,1.3);

alarm[0] = 1;
momentum_transfer = function(_hitter){
	// Split if the hitter can
	if ((object_get_name(_hitter.object_index) != "obj_asteroid" && abs(_hitter.spd) > 20 * (size + 1)) || (object_get_name(_hitter.object_index) = "obj_asteroid" && (_hitter.size >= size || abs(_hitter.spd) / (1 + (size - _hitter.size)) > 20))){
		
		repeat(irandom_range(3 * (size + 1),6 * (size + 1))){
			var part = instance_create_depth(x + irandom_range(-sprite_width, sprite_width) / 2,y + irandom_range(-sprite_height,sprite_height) / 2,0,obj_asteroid_particle);
			part.direction = dir + random_range(-30, 30);
			part.speed = spd * random_range(0.9,1.1) * global.delta;
			//part.image_speed *= 1 - (size / 6);
		}
		shake_camera(3 * dropoff,dir);
		split();
	}
	
	// Ratio for how much to change the angle
	var ratio = 0;
	if (_hitter.spd / 10 > spd)ratio = abs(spd) / (abs(spd) + abs(_hitter.spd / 10));
	else ratio = abs(_hitter.spd / 10) / (abs(spd) + abs(_hitter.spd / 10));
	
	// Change the direction
	dir += angle_difference(_hitter.dir, dir) * ratio;
	
	// Take some of the speed
	spd += _hitter.spd * 0.1;
	
}

split = function(){
	
	var newSprite = spr_asteroid_large;
	if (size = 2)newSprite = spr_asteroid_medium;
	if (size = 1)newSprite = spr_asteroid_tiny;
	if (size = 0){
		instance_destroy();
		return;
	}
	
	mask_index = newSprite;
	repeat(irandom_range(2,3)){
		
		var success = false;
		var i = 0;
		
		while(success = false && i < 10){
			var newX = x + irandom_range(-sprite_width, sprite_width);
			var newY = y + irandom_range(-sprite_height,sprite_height);
			
			if (!place_meeting(newX,newY,[collision,obj_platform])){
				var child = instance_create_depth(newX,newY,0,obj_asteroid);
				child.size = size - 1;
				child.sprite_index = newSprite;
				success = true;
			}
			i ++;
		}
	}
	
	instance_destroy();
}