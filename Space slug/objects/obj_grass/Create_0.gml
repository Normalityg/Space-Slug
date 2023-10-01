scorePotential = 0;

if (collision_circle(x,y,4,obj_grass,true,true) || !(place_meeting(x,y,obj_platform) && place_meeting(x + 3,y,obj_platform) && place_meeting(x + 3,y,obj_platform) && place_meeting(x,y - 1,obj_platform) && place_meeting(x,y + 2,obj_platform)))instance_destroy();
image_index = irandom_range(0,5);
lifeTime = random_range(8,20);
reproTime = random_range(0,lifeTime - 1);

depth = 2;

boost = 1;
if (instance_number(obj_node) != 0 && point_distance(x,y,instance_nearest(x,y,obj_node).x,instance_nearest(x,y,obj_node).y) < 48)boost = 2;