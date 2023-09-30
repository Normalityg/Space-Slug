if (sprite_index = -1){ // If the asteroid still has no sprite give it one
	sprite_index = spr_asteroid_tiny;
	if (size = 1)sprite_index = spr_asteroid_medium;
	if (size = 2)sprite_index = spr_asteroid_large;
}