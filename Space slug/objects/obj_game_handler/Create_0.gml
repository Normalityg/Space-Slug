replenish = true;
instance_create_depth(0,0,0,obj_player);

for(var i = 0; i < 500; i ++){
	var newX = irandom_range(-(500 + i * 5),500 + i * 5),;
	var newY = irandom_range(-(500 + i * 5),500 + i * 5),
	
	if (point_distance(0,0,newX,newY) < 160 + i)continue;
	
	instance_create_depth(newX,newY,0,obj_node);
}