if (irandom_range(0,30) = 0){
	dir = global.solarDirection;
	spd = global.solarSpeed;
}

x += dcos(dir) * spd * global.delta;
y += -dsin(dir) * spd * global.delta;

lifeSpan -= global.delta;
if (lifeSpan < 0)instance_destroy();

image_alpha -= 0.0005;