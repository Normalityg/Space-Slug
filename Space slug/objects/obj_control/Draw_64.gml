if (room != rm_game && room != rm_tutorial)return;
// Tint the world
draw_set_color(#363636);
draw_set_alpha(0.3);
draw_rectangle(0,0,camera.view_width,camera.view_height,false);
draw_set_color(c_white);
draw_set_alpha(1);

// Current score
draw_text(camera.view_width / 2 - string_length(string(round(global.currentScore))) * 4,2,round(global.currentScore));
// Potential score
if (potentialScoreAnim != -1){
	var progress = potentialScoreAnim.progress();
	draw_text_transformed(camera.view_width / 2 - (string_length(string(round(global.potentialScore))) * 4) * (progress + 0.1),16,round(global.potentialScore),progress + 0.1,progress + 0.1,sin(current_time / 1000 * (1 + progress * 3)) * 4);

	if (progress = 1){
		global.currentScore += global.potentialScore;
		scoreAddWait = new animTracker(20);
		potentialScoreAnim = -1;
		
	}
}
if (scoreAddWait != -1 && scoreAddWait.progress() = 1){
	potentialScoreAnim = new animTracker(10);
	scoreAddWait = -1;
}