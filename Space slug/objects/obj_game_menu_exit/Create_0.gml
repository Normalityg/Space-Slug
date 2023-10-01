event_inherited();

sprite = spr_game_menu;
spriteHover = spr_game_menu_hovered;

action = function(){
	var transition = instance_create_depth(device_mouse_x_to_gui(0),device_mouse_x_to_gui(0),0,obj_room_transition);
	transition.myRoom = rm_main_menu;
};