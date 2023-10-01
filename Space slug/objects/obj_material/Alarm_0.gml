var tries = 0;
while(place_meeting(x,y,obj_collision)){ // Shuffle until a good spot is found
	x += irandom_range(-tries,tries);
	y += irandom_range(-tries,tries);
	tries ++;
}