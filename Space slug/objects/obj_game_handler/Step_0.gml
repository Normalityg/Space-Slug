if (replenish = true){
	if (irandom_range(0,5) = 0){
		
		if (instance_number(obj_platform) >= 10){
			if (instance_number(obj_printer) = 0){
				var newX = irandom_range(-70,70);
				var newY = irandom_range(-50,50);
				var tries = 0;
				mask_index = spr_node;
				while (place_meeting(newX,newY,obj_collision)){
					newX = irandom_range(-70 - tries,70 + tries);
					newY = irandom_range(-50 - tries,50 + tries);
					
					tries ++;
				}
				instance_create_depth(newX,newY,0,obj_node);
				
				var newX = irandom_range(-70,70);
				var newY = irandom_range(-50,50);
				var tries = 0;
				mask_index = spr_printer;
				while (place_meeting(newX,newY,obj_collision)){
					newX = irandom_range(-70 - tries,70 + tries);
					newY = irandom_range(-50 - tries,50 + tries);
					
					tries ++;
				}
				instance_create_depth(newX,newY,0,obj_printer);
			}
			else {
				instance_destroy();
			}
		}
		
		var newX = irandom_range(-70,70);
		var newY = irandom_range(-50,50);
		
		if (instance_number(obj_platform) != 0)var nearest = instance_nearest(newX,newY,obj_platform);
		else {
			instance_create_depth(newX,newY,0,obj_platform);
			repeat(irandom_range(3,8))instance_create_depth(newX + irandom_range(4,20),newY + irandom_range(4,20),0,obj_grass);
			return;
		}
		
		while (40 < point_distance(newX,newY,nearest.x,nearest.y) && point_distance(newX,newY,nearest.x,nearest.y) > 9){
			newX = irandom_range(-70,70);
			newY = irandom_range(-50,50);
			
			nearest = instance_nearest(newX,newY,obj_platform);
		}
		instance_create_depth(newX,newY,0,obj_platform);
		repeat(irandom_range(3,8))instance_create_depth(newX + irandom_range(4,20),newY + irandom_range(4,20),0,obj_grass);
	}
}