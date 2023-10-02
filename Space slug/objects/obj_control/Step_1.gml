var keyPause = keyboard_check_pressed(vk_escape);

if (!global.alive && room != rm_main_menu)return; // Skip when the palyer is dead

if (keyPause && room != rm_main_menu){
	if (!global.paused && global.alive){ // Pause
		
		global.paused = true;
		
		var X = camera.camX - camera.view_width / 2 + 88;
		var Y = camera.camY - camera.view_height / 2;
		
		// Paused text
		instance_create_depth(X + 8, Y + 24, 0, obj_paused_title);
		instance_create_depth(X + 28, Y + 24, 0, obj_paused_title);
		instance_create_depth(X + 48, Y + 24, 0, obj_paused_title);
		instance_create_depth(X + 68, Y + 24, 0, obj_paused_title);
		instance_create_depth(X + 88, Y + 24, 0, obj_paused_title);
		instance_create_depth(X + 108, Y + 24, 0, obj_paused_title);
		
		// Resume, Options, Menu
		instance_create_depth(X + 72, Y + 86, 0, obj_paused_menu_resume);
		instance_create_depth(X + 72, Y + 110, 0, obj_game_menu_exit);
		//instance_create_depth(X + 72, Y + 134, 0, obj_game_menu_exit);
	}
	else { // Unpause
		global.paused = false;
		instance_destroy(obj_paused_title);
		
		instance_destroy(obj_paused_menu_resume);
		//instance_destroy(obj_main_menu_options);
		instance_destroy(obj_game_menu_exit);
	}
}

global.delta = delta_time / 1000000 * !global.paused;
global.currentTime += global.delta * 1000;

global.solarDirection += random(1) - 0.5;

#region Chaning wind direction

if (windChangeAnim.progress() = 1){
	var length = random_range(2.4,7);
	windChange = random_range(-4 * length,4 * length);
	if (waveState = 1)windChange *= random_range(2,3);
	windChangeStart = global.solarDirection;
	windChangeAnim = new animTracker(length);
}
else{
	global.solarDirection = (windChangeStart + (windChange * windChangeAnim.progress()) + 360) % 360;
}

#endregion

if (room = rm_tutorial)global.solarDirection = 180;
if (room != rm_game)return; // No code below here outside of the game

#region Asteroid spawning

waveTimer -= global.delta;
groupTimer -= global.delta;

if (waveTimer <= 0){
	warned = false;
	
	waveState = (waveState + 1) % 3;
	
	waveSpeedTracker = new animTracker(5);
	
	if (waveState = 0)waveTimer = waveFrequency;
	if (waveState = 1){
		groupTimer = random_range(0.7,1.4);
		waveTimer = waveLength;
	}
	if (waveState = 2)waveTimer = waveRecovery;
}

if (waveState = 1)global.solarSpeed = normalSpeed + (waveSpeed - normalSpeed) * waveSpeedTracker.progress();
if (waveState = 2)global.solarSpeed = waveSpeed + (normalSpeed - waveSpeed) * waveSpeedTracker.progress();

if (waveState = 0 && groupTimer <= 0){
	
	groupTimer = irandom_range(1.6,3.4);
	
	var target = instance_find(obj_platform, irandom_range(0,instance_number(obj_platform) - 1));
	var count = irandom_range(1,5);
	show_debug_message(count)
	// Go upstream a certain amount of time and spawn it
	var arriveTime = irandom_range(3,7);
	var closestPlatform = -1;
	if (room = rm_tutorial)arriveTime = 9;
	
	var zoneX = target.x - dcos(global.solarDirection) * global.solarSpeed * arriveTime;
	var zoneY = target.y + dsin(global.solarDirection) * global.solarSpeed * arriveTime;
	
	var distanceMult = 1;
	// Make sure that the spawned asteroids are not within a range of a platform or else move them *1.1 until they are
	while(closestPlatform = -1 || 450 > point_distance(zoneX * distanceMult,zoneY * distanceMult,closestPlatform.x,closestPlatform.y)){
		
		distanceMult *= 1.1;
		closestPlatform = instance_nearest(zoneX * distanceMult,zoneY * distanceMult,obj_platform);
	}
	
	var variance = 48 * count;
	
	// Choose what to spawn
	while(count > 0){
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
			
			count += 5;
		}
		else{ // The rest create an asteroid
			// Decide the size
			var size = 0;
			if (irandom_range(0,15) = 0 && count >= 3){ // 1 in 14 become medium
				size = 1;
				if (irandom_range(0,6) = 0 && count >= 5)size = 2; // 1 in 98 become large
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
			
			count -= size + 1;
		}
	}
}

if (waveState = 1 && groupTimer <= 0){ // If a wave is active and random chance
	
	groupTimer = random_range(0.9,1.7);
	
	// Pick a platform to target
	var target = instance_find(obj_platform, irandom_range(0,instance_number(obj_platform) - 1));

	// Figure out how many platforms are nearby
	var threatList = ds_list_create();
	collision_circle_list(target.x + 12,target.y + 12,12,obj_platform,true,true,threatList,false);
	var threatSize = 1 + ds_list_size(threatList);
	var threat = threatSize * (1 + 0.5 * (threatSize - 1));
		show_debug_message(threat)
	// Go upstream a certain amount of time and spawn it
	var arriveTime = 2 + logn(1.4,threat);
	var closestPlatform = -1;
	if (room = rm_tutorial)arriveTime = 9;
	
	var zoneX = target.x - dcos(global.solarDirection) * global.solarSpeed * arriveTime;
	var zoneY = target.y + dsin(global.solarDirection) * global.solarSpeed * arriveTime;
	
	var distanceMult = 1;
	// Make sure that the spawned asteroids are not within a range of a platform or else move them *1.1 until they are
	while(closestPlatform = -1 || 500 > point_distance(zoneX * distanceMult,zoneY * distanceMult,closestPlatform.x,closestPlatform.y)){
		
		distanceMult *= 1.1;
		closestPlatform = instance_nearest(zoneX * distanceMult,zoneY * distanceMult,obj_platform);
	}
	
	var variance = 48 + threat * 4;
	
	// Choose what to spawn
	while(threat > 0){
		// Decide the size
		var size = 0;
		if (irandom_range(0,9) = 0){ // 1 in 10 become medium
			size = 1;
			if (irandom_range(0,12) = 0)size = 2; // 1 in 96 become large
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
	ds_list_destroy(threatList);
}

// Spawn to target the player
// Make sure its not near any grass or the printer
#endregion

#region Game overing

if (global.alive && instance_number(obj_grass) = 0 && !instance_exists(obj_game_handler)){
	global.alive = false;
	
	potentialScoreAnim = -1;
	
	oldHighScore = global.highScore;
	
	if (global.currentScore > global.highScore){
		global.highScore = global.currentScore;
		
		ini_open("save.ini");
		ini_write_real("data","highscore",global.highScore);
		ini_close();
		
		scoreGainAnim = new animTrackerFreed(8);
		audio_play_sound(snd_drumroll_long,0,false);
	}
	else{
		scoreGainAnim = new animTrackerFreed(5);
		audio_play_sound(snd_drumroll_short,0,false);
	}
	
	instance_destroy(obj_player);
	
	instance_create_depth(camera.camX,camera.camY + 24,0,obj_game_menu_restart);
	instance_create_depth(camera.camX,camera.camY + 48,0,obj_game_menu_exit);
}

#endregion

if (warned = false && waveState = 1 && groupTimer <= 5 / waveFrequency){
	warned = true;
	instance_create_depth(180,60,0,obj_warning_imminent);
}