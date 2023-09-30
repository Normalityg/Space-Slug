// Create objects in order
instance_create_depth(x,y,0,camera);

draw_set_font(fnt_default);

global.delta = 0;

global.solarSpeed = 32;
global.solarDirection = 210;

global.currentScore = 0;
global.potentialScore = 0;

// Internal variable
potentialScoreAnim = -1;
scoreAddWait = new animTracker(10);