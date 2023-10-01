var keyClick = mouse_check_button(mb_left);

knobX = sliderX + 72 * global.volume;
knobY = sliderY;

knobSprite = spr_options_knob;

if (point_in_circle(mouse_x,mouse_y,x + knobX + 12,y + knobY + 12, 12)){
	knobSprite = spr_options_knob_hovered;
	if (keyClick){
		held = true;
		
		knobSprite = spr_options_knob_held;
		
		global.volume = clamp((mouse_x - sliderX) / 72,0,1);
		
	}
	else held = false;
	
}