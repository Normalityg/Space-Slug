if (hovering && hoveringAnim.progress() > 0.3){
	draw_set_font(global.fontNumbers);
	//draw_text(124,88,"High: " + string(round(global.highScore)));
	draw_text(124,108,"High: " + string(round(global.highScore)));
	draw_set_font(-1);
}

// Inherit the parent event
event_inherited();

