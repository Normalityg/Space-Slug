if (irandom_range(0,20) = 0){
	var zoneX = camera.x - dcos(global.solarDirection) * global.solarSpeed * 8;
	var zoneY = camera.y + dsin(global.solarDirection) * global.solarSpeed * 8;
	// Decide the size
	var size = 0;
	if (irandom_range(0,15) = 0){ // 1 in 14 become medium
		size = 1;
		if (irandom_range(0,6) = 0)size = 2; // 1 in 98 become large
	}
	// Get the sprite
	var newSprite;
	if (size = 0)newSprite = spr_asteroid_tiny;
	if (size = 1)newSprite = spr_asteroid_medium;
	if (size = 2)newSprite = spr_asteroid_large;
	
	mask_index = newSprite;
	
	var success = false;
	var i = 0;
	
	while(success = false && i < 10){
		var newX = zoneX + irandom_range(-200, 200);
		var newY = zoneY + irandom_range(-200, 200);
		
		if (!place_meeting(newX,newY,[collision,obj_platform])){
			
			var ast = instance_create_depth(newX,newY,0,obj_asteroid);
			ast.size = size;
			ast.sprite_index = newSprite;
			success = true;
		}
		i ++;
	}
	mask_index = -1;
}

if (instance_number(obj_platform) = 0 && irandom_range(0,60) = 0){
	replenish = true;
}

if (replenish = true){
	if (instance_number(obj_platform) = 12)replenish = false;
	
	if (irandom_range(0,20) = 0){
		var newX = irandom_range(140,260);
		var newY = irandom_range(40,160);
		
		if (instance_number(obj_platform) != 0)var nearest = instance_nearest(newX,newY,obj_platform);
		else {
			instance_create_depth(newX,newY,0,obj_platform);
			repeat(irandom_range(3,8))instance_create_depth(newX + irandom_range(4,20),newY + irandom_range(4,20),0,obj_grass);
			return;
		}
		
		while (40 < point_distance(newX,newY,nearest.x,nearest.y) && point_distance(newX,newY,nearest.x,nearest.y) > 9){
			newX = irandom_range(140,260);
			newY = irandom_range(40,160);
			
			nearest = instance_nearest(newX,newY,obj_platform);
		}
		instance_create_depth(newX,newY,0,obj_platform);
		repeat(irandom_range(3,8))instance_create_depth(newX + irandom_range(4,20),newY + irandom_range(4,20),0,obj_grass);
	}
}