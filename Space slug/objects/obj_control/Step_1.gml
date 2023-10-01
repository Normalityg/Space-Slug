global.delta = delta_time / 1000000;

if (mouse_check_button_pressed(mb_left))instance_create_depth(mouse_x,mouse_y,0,obj_material);

global.solarDirection += random(1) - 0.5;

if (room != rm_game)return; // No code below here outside of the game
if (room = rm_tutorial)global.solarDirection = 180;

#region Asteroid spawning
if (irandom_range(0,240) = 0){
// Pick a platform to target
var target = instance_find(obj_platform, irandom_range(0,instance_number(obj_platform) - 1));

// Figure out how many platforms are nearby
	var threatList = ds_list_create();
	collision_circle_list(target.x + 12,target.y + 12,12,obj_platform,true,true,threatList,false);
	var threatSize = ds_list_size(threatList);
var threat = threatSize * (1 + 0.5 * (threatSize - 1));
show_debug_message("threat" + string(threat));
// Go upstream a certain amount of time and spawn it
var arriveTime = 6 + logn(1.4,threat);
var closestPlatform = -1;
if (room = rm_tutorial)arriveTime = 9;

var zoneX = target.x - dcos(global.solarDirection) * global.solarSpeed * arriveTime;
var zoneY = target.y + dsin(global.solarDirection) * global.solarSpeed * arriveTime;

var distanceMult = 1;
// Make sure that the spawned asteroids are not within a range of a platform or else move them *1.1 until they are
while(closestPlatform = -1 || 600 > point_distance(zoneX * distanceMult,zoneY * distanceMult,closestPlatform.x,closestPlatform.y)){
	
	distanceMult *= 1.1;
	closestPlatform = instance_nearest(zoneX * distanceMult,zoneY * distanceMult,obj_platform);
}

var variance = 48 + threat * 4;

// Choose what to spawn
while(threat > 0){
	// 1 in 100 become a material instead
	if (irandom_range(0,99) = 0){
		var newX = zoneX * distanceMult + irandom_range(-variance, variance);
		var newY = zoneY * distanceMult + irandom_range(-variance, variance);
		
		mask_index = spr_material;
		
		var success = false;
		var i = 0;
		
		while(success = false && i < 10){
			var newX = zoneX * distanceMult + irandom_range(-variance, variance);
			var newY = zoneY * distanceMult + irandom_range(-variance, variance);
			
			if (!place_meeting(newX,newY,[collision,obj_platform])){
				instance_create_depth(newX,newY,0,obj_material);
				success = true;
			}
			i ++;
		}
		mask_index = -1;
		
		threat += 5;
	}
	else{ // The rest create an asteroid
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
			var newX = zoneX * distanceMult + irandom_range(-variance, variance);
			var newY = zoneY * distanceMult + irandom_range(-variance, variance);
			
			if (!place_meeting(newX,newY,[collision,obj_platform])){
				
				var ast = instance_create_depth(newX,newY,0,obj_asteroid);
				ast.size = size;
				ast.sprite_index = newSprite;
				success = true;
			}
			i ++;
		}
		mask_index = -1;
		
		threat -= size + 1;
	}
	
}
// Spawn multiple if there are a lot of platforms near it
ds_list_destroy(threatList);

// Spawn to target the player
// Make sure its not near any grass or the printer
}
#endregion