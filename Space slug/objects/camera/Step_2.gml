camera_set_view_size(view_camera[0], view_width, view_height);

// Move camera
//x = obj_engineer.x;
//y = obj_engineer.y;
//
camX = obj_player.x + (dcos(obj_player.dir) * obj_player.spd / 4); //lerp(x, mouse_x,0.2);
camY = obj_player.y - (dsin(obj_player.dir) * obj_player.spd / 4) * (view_height / view_width); //lerp(y, mouse_y,0.2);

// Apply screenshake to the camera
var shakeProgress = sin(shakeTimer * shakeFrequency);

var rad = degtorad(shakeDirection);

shakeX = shakeProgress * shakeIntensity * cos(rad);
shakeY = shakeProgress * shakeIntensity * sin(rad);

// Lower screenshake frequency and intersity over time
if (shakeFrequency > 0)shakeFrequency -= (shakeDecay * global.delta) * shakeFrequency;
if (shakeFrequency < 0.05)shakeFrequency = 0;
shakeIntensity = shakeFrequency * 1;

// Set real camera position
camera_set_view_pos(view_camera[0], round(camX + shakeX- view_width / 2), round(camY + shakeY - view_height / 2));
//camera_set_view_angle(view_camera[0], shakeRollDirection * shakeProgress * (shakeFrequency * 0.2));

// Increase the shakeTimer
shakeTimer += global.delta;