// Change image index

if (hp > 60)image_index = 0;
else if (hp > 20)image_index = 1;
else image_index = 2;

// Draw
draw_style();
draw_self();