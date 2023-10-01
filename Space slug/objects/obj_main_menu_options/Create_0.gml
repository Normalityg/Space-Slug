event_inherited();

sprite = spr_menu_options;
spriteHover = spr_menu_options_hovered;

action = function(){
	instance_create_depth(mouse_x,mouse_y,0,obj_ranoutoftime);
	show_debug_message("Press more buttons!")
	global.inOptions = true;
};