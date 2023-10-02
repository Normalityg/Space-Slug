if (instance_number(obj_control) > 1)instance_destroy(); // Dont have multiple controls

draw_set_font(fnt_default);

global.delta = 0;
global.paused = false;

global.volume = 1;

global.inOptions = false;

global.solarSpeed = 16;
global.solarDirection = 210;

global.playingGame = false;
global.alive = false;

global.highScore = 0;
global.currentScore = 0;
global.potentialScore = 0;

global.beatTutorial = false;

global.currentTime = 0;

global.fontNumbers = font_add_sprite_ext(spr_font_numbers, "0123456789", true, 1);

// Loading from file
if (file_exists("save.ini")){
	ini_open("save.ini");
	
	global.highScore = ini_read_real("data","highscore",0);
	
	global.beatTutorial = ini_read_real("data","tutorialState",false);
	
	ini_close();
}

// Internal variables
potentialScoreAnim = -1;
scoreAddWait = new animTracker(5 + 50);

windChange = 30
windChangeStart = global.solarDirection;
windChangeAnim = new animTracker(3);

waveState = 2;
waveTimer = 5;

groupTimer = 0;

waveLength = 15; // 15 seconds of wave
waveRecovery = 10; // 15 seconds before the points are given and asteroids start spawning again
waveFrequency = 50; // 90 seconds of low asteroid amount

normalSpeed = 16;
waveSpeed = 48;

scoreGainAnim = -1;
confettiAnim = -1;
confettiOverAnim = -1;

oldHighScore = 0;

warned = false;

waveSpeedTracker = new animTracker(-1);
audio_play_sound(snd_wind,1,true);