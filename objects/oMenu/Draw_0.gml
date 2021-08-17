var x_size = 300
var y_size = 150

if (anim_frame < max_anim_frame)
{
	anim_frame++
	var perc = anim_frame / max_anim_frame
	x_size = x_size * perc
	y_size = y_size * perc
}

var xx1 = center.xx - x_size
var yy1 = center.yy - y_size
var xx2 = center.xx + x_size
var yy2 = center.yy + y_size

//draw_rounded_box_outline(xx1, yy1, xx2, yy2, 10, c_black, 0.8, c_white)

draw_rounded_popup(xx1, yy1, xx2, yy2)

if (anim_frame >= max_anim_frame)
{
	xx1 = center.xx - 230
	yy1 = center.yy - 80
	//draw_sprite(sNoInternet, 0, center.xx + 30, yy1)
	draw_text(xx1, yy1, "No internet")
	Draw_text_color_size(xx1, yy1 + 60, "Try:", c_white, 1, 0.65)
	Draw_text_color_size(xx1 + 10, yy1 + 80, "- Checking the network cables, modem and router", c_white, 1, 0.65)
	Draw_text_color_size(xx1 + 10, yy1 + 100, "- Reconnecting to WI-FI", c_white, 1, 0.65)
	Draw_text_color_size(xx1 + 10, yy1 + 120, "- Taking back your router from the aliens!", c_aqua, 1, 0.65)
	Draw_text_color_size(xx1, yy1 + 160, "ERR_INTERNET_DISCONNECTED", c_white, 1, 0.65)

	InstanciateButton(xx2 - 180, yy1 + 180)
}

Draw_text_color_outline(x1 + 10, y2 - 45, creditText, c_white, 1, c_black, 1, 1, 20, 0.65, 0.65, 0)
