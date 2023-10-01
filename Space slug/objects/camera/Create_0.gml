view_width = 1920 / 6;
view_height = 1080 / 6;

window_scale = 4;

if (global.settings = true)window_set_size(view_width * window_scale,view_height * window_scale);

// Set gui size so everything is the same size no matter the window size
//display_set_gui_size(view_width,view_height);

alarm[0] = 1;

surface_resize(application_surface,view_width,view_height);


// Camera variables
camX = 0;
camY = 0;

shakeX = 0;
shakeY = 0;

shakeFrequency = 20;
shakeIntensity = 5;
shakeDecay = 10;
shakeVariance = 20;

shakeTimer = 0;

shakeDirection = 0;
shakeRollDirection = 1;