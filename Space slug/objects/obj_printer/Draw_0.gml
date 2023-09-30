// Producing animation
if (produceAnim != -1){
	var progress = -sqr(2 * produceAnim.progress() - 1) + 1;
	image_xscale = 1 + progress / 4;
	image_yscale = 1 - progress / 4;
	image_angle = produceAnim.progress() * 180;
}

// Normal
else image_angle = imageangle;
draw_style();
image_angle = 0;

//image_xscale = 1;
//image_yscale = 1;