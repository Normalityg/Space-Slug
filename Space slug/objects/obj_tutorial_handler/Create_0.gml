/*depth = -99;
replenish = false;

#region Prefill the screen with asteroids
repeat(70){
	var zoneX = camera.x - dcos(global.solarDirection) * global.solarSpeed * random_range(2,6);
	var zoneY = camera.y + dsin(global.solarDirection) * global.solarSpeed * random_range(2,6);
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
#endregion