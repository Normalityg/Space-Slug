if (hovering = true)sprite_index = spriteHover;
else sprite_index = sprite;

var quadProgress = 1;

if (hoveringAnim != -1)//quadProgress += (-sqr(2 * hoveringAnim.progress() - 1) + 1) * 0.2;
if (hoveringAnim != -1)quadProgress += sin(hoveringAnim.progress() * 30) / (hoveringAnim.progress() * 30) * 0.3;
draw_sprite_ext(sprite_index, image_index, x + 2, y + 2, image_xscale * quadProgress, image_yscale * quadProgress, image_angle, #111111, 0.5);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * quadProgress, image_yscale * quadProgress, image_angle, c_white, 1);