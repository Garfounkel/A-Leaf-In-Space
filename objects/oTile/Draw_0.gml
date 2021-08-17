draw_self();

//draw_text_transformed(x, y, string(x) + ", " + string(y), 0.25, 0.25, 0);
//var c = c_red
//draw_text_transformed_color(centerX-8, centerY-2, string(centerX) + ", " + string(centerY), 0.25, 0.25, 0, c,c,c,c, 255);

if (occupied)
{
	draw_set_alpha(0.1)
	draw_rectangle_color(x, y, x + 31, y + 31, c_green, c_green, c_green, c_green, false)
	draw_set_alpha(1)
}
