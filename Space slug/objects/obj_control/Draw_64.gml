if (scoreGainAnim != -1){
	
	draw_set_font(global.fontNumbers);
	
	// High score
	draw_text(camera.view_width / 2 - string_length(string(round(oldHighScore))) * 6,2,round(oldHighScore));
	
	var progress = scoreGainAnim.progress();

	// Current score
	if (progress < 1)draw_text_transformed(camera.view_width / 2 - (string_length(string(round(global.currentScore * progress))) * 6.5) * (1.7 * progress + 0.1),48,round(global.currentScore * progress),progress* 1.5 + 0.5,progress* 1.5 + 0.5,sin(current_time / 800 * (1 + progress * 9)) * 4);
	else{
		if (instance_number(obj_confetti_particle) = 0)audio_play_sound(snd_claps,0,false);
		draw_text_transformed(camera.view_width / 2 - (string_length(string(round(global.currentScore))) * 6.5) * (1.7 * progress + 0.1),48,round(global.currentScore),progress * 1.5 + 0.5,progress* 1.5 + 0.5,0);
		
		//if (global.currentScore > oldHighScore){
			if (confettiAnim = -1)confettiAnim = new animTrackerFreed(3);
			
			var confettiProg = confettiAnim.progress();
			if (confettiProg = 1 && confettiOverAnim = -1)confettiOverAnim = new animTrackerFreed(6);
			
			var confetti = 0;
			if (confettiOverAnim != -1)confetti = confettiOverAnim.progress();
			
			if (confettiOverAnim = -1 || confetti < 1)repeat(irandom_range(0,25 - (24 * confettiProg)))instance_create_depth(camera.view_width / 2, 66,0,obj_confetti_particle);
		//}
	}
	draw_set_font(-1);
}

if (room != rm_game && room != rm_tutorial)return;
// Tint the world
draw_set_color(#363636);
draw_set_alpha(0.3);
if (global.paused){
	draw_set_alpha(0.8)
	draw_set_color(#101010);
}
draw_rectangle(0,0,camera.view_width,camera.view_height,false);
draw_set_color(c_white);
draw_set_alpha(1);

// Current score
//draw_text(camera.view_width / 2 - string_length(string(round(global.currentScore))) * 4,2,round(global.currentScore));
// Potential score
if (potentialScoreAnim != -1){
	var progress = potentialScoreAnim.progress();
	
	draw_set_font(global.fontNumbers);
	draw_text_transformed(camera.view_width / 2 - (string_length(string(round(global.potentialScore))) * 6) * (progress + 0.1),16,round(global.potentialScore),progress + 0.1,progress + 0.1,sin(current_time / 1000 * (1 + progress * 3)) * 4);
	draw_set_font(-1);
	
	if (progress = 1){
		global.currentScore += global.potentialScore;
		scoreAddWait = new animTracker(waveFrequency + waveRecovery);
		potentialScoreAnim = -1;
		
	}
}
if (scoreAddWait != -1 && scoreAddWait.progress() = 1){
	potentialScoreAnim = new animTracker(waveLength);
	scoreAddWait = -1;
}