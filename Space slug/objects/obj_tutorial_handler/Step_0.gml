instance_deactivate_object(obj_wall);
instance_activate_region(camera.camX - camera.view_width / 2,camera.camY - camera.view_height / 2,camera.view_width,camera.view_height,true);

if (instance_number(obj_grass) > 21 && global.alive = true){
	ini_open("save.ini")
	ini_write_real("data","tutorialState",true);
	ini_close();
	
	global.alive = false;
	instance_destroy(obj_player);
	
	
	instance_create_depth(camera.camX,camera.camY + 24,0,obj_tutorial_menu_next);
	instance_create_depth(camera.camX,camera.camY + 48,0,obj_game_menu_exit);
}

if (irandom_range(0,20) = 0){
	var zoneX = irandom_range(1200,1450);
	var zoneY = irandom_range(-200,300);
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
		var newX = zoneX + irandom_range(-80, 80);
		var newY = zoneY + irandom_range(-80, 80);
		
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