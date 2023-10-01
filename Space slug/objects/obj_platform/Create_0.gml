repeat(irandom_range(4,7))instance_create_depth(x + random(24),y + random(24),0,obj_platform_particle);

image_angle = irandom_range(-4,4) * 2;
depth = irandom_range(3,8);
image_xscale = random_range(0.9,1.1);
image_yscale = random_range(0.9,1.1);

image_index = irandom(2);
hp = 100;

if (room != rm_tutorial)audio_play_sound(snd_print1,0,false,1 - point_distance(x,y,camera.x,camera.y) / 400);