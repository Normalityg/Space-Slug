quadProgress = held * 1.2;

draw_sprite_ext(spr_options_slider, image_index, x + 2, y + 2, image_xscale * quadProgress, image_yscale * quadProgress, image_angle, #111111, 0.5);
draw_sprite_ext(knobSprite, image_index, x + 2, y + 2, image_xscale * quadProgress, image_yscale * quadProgress, image_angle, #111111, 0.5);
draw_sprite_ext(spr_options_slider, image_index, x, y, image_xscale * quadProgress, image_yscale * quadProgress, image_angle, c_white, 1);
draw_sprite_ext(knobSprite, image_index, x, y, image_xscale * quadProgress, image_yscale * quadProgress, image_angle, c_white, 1);