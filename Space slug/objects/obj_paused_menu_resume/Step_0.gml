if (position_meeting(mouse_x,mouse_y,object_index)){
	if (hovering = false){
		image_speed = 1;
		hoveringAnim = new animTracker(0.9);
		audio_play_sound(snd_grass1,0,false);
	}
	hovering = true;
	
}
else {
	hovering = false;
}

if (mouse_check_button_pressed(mb_left) && hovering)action();