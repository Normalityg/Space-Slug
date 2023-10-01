var quadProgress = 1 + sin(hoveringAnim.progress() * 30) / (hoveringAnim.progress() * 30) * 0.3;

if (hoveringAnim.progress() = 1){
	image_alpha -= 0.03;
	if (image_alpha <= 0)instance_destroy();
}


draw_sprite_ext(sprite_index, image_index, x + 2, y + 2, image_xscale * quadProgress, image_yscale * quadProgress, image_angle + sin(current_time / 333), #111111, image_alpha / 2);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * quadProgress, image_yscale * quadProgress, image_angle + sin(current_time / 333), c_white, image_alpha);