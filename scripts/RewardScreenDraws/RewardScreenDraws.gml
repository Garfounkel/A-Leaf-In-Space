function get_center(x1, y1, x2, y2)
{
	var center_x = round(x1 + abs(x2 - x1) / 2)
	var center_y = round(y1 + abs(y2 - y1) / 2)
	return new point(center_x, center_y)
}

function draw_roundex_box_alpha(x1, y1, x2, y2, radius, color, alpha, outline)
{
	var saved_alpha = draw_get_alpha()
	draw_set_alpha(alpha)
	draw_roundrect_color_ext(x1, y1, x2, y2, radius, radius, color, color, outline)
	draw_set_alpha(saved_alpha)
}

function draw_rounded_box_outline(x1, y1, x2, y2, radius, color, alpha, outline_color)
{
	draw_roundex_box_alpha(x1, y1, x2, y2, radius, color, alpha, false)
	draw_roundrect_color_ext(x1, y1, x2, y2, radius, radius, outline_color, outline_color, true)
}

function draw_rounded_popup(x1, y1, x2, y2)
{
	draw_sprite_stretched_ext(sPopupFrameTransparent, 0, x1, y1, abs(x2-x1), abs(y2-y1), c_white, 1)
}