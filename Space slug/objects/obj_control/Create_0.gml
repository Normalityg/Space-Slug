if (instance_number(obj_control) > 1)instance_destroy(); // Dont have multiple controls

draw_set_font(fnt_default);

global.delta = 0;

global.solarSpeed = 32;
global.solarDirection = 210;

global.alive = true;

global.highScore = 0;
global.currentScore = 0;
global.potentialScore = 0;

// Internal variable
potentialScoreAnim = -1;
scoreAddWait = new animTracker(10);

audio_play_sound(snd_wind,1,true);