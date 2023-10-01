hovering = false;
hoveringAnim = -1;

image_speed = 0;
depth = -100;

sprite = spr_game_resume;
spriteHover = spr_game_resume_hovered;

action = function(){
	global.paused = false;
	
	instance_destroy(obj_paused_title);
	
	instance_destroy(obj_paused_menu_resume);
	//instance_destroy(obj_main_menu_options);
	instance_destroy(obj_game_menu_exit);
};