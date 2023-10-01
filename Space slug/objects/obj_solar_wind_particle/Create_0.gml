if (instance_number(obj_solar_wind_particle) > 400)instance_destroy();
image_index = round(clamp(round(global.solarSpeed / 32) + irandom_range(-1,1),0,4));
depth = 10;

dir = global.solarDirection;
spd = global.solarSpeed;

lifeSpan = random_range(2,5);