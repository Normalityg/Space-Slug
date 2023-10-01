// Create objects in order
if (room != "rm_game"){
	instance_create_depth(x,y,0,camera);
	instance_create_depth(x,y,0,obj_player);
}