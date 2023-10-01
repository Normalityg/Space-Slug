event_inherited();

sprite = spr_menu_play;
spriteHover = spr_menu_play_hovered;

action = function(){
	var transition = instance_create_depth(mouse_x,mouse_y,0,obj_room_transition);
	if (global.beatTutorial)transition.myRoom = rm_game;
	else transition.myRoom = rm_tutorial;
};