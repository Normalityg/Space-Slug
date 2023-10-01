quadProgress = (sin(current_time / 660 - ((image_index - ((y / 24) - 1) * 2.5))* 0.7) + 1) / 2;

draw_sprite_ext(sprite_index, image_index, x + 2 + quadProgress, y + 2 + quadProgress * 6, image_xscale, image_yscale, image_angle, #111111, 0.5);
draw_sprite_ext(sprite_index, image_index, x + quadProgress, y + quadProgress * 6, image_xscale, image_yscale, image_angle, c_white, 1);