var x_size = 300
var y_size = 150

//if (anim_frame < max_anim_frame)
//{
//	anim_frame++
//	var perc = anim_frame / max_anim_frame
//	x_size = x_size * perc
//	y_size = y_size * perc
//}

var xx1 = center.xx - x_size
var yy1 = center.yy - y_size
var xx2 = center.xx + x_size
var yy2 = center.yy + y_size

//draw_rounded_box_outline(xx1, yy1, xx2, yy2, 10, c_black, 0.8, c_white)

draw_rounded_popup(xx1, yy1, xx2, yy2)

xx1 = center.xx - 230
yy1 = center.yy - 80
//draw_sprite(sNoInternet, 0, center.xx + 30, yy1)
Draw_text_color_size(xx1, yy1, "Fight UFOs until they give back your router.", c_white, 1, 0.65)
Draw_text_color_size(xx1, yy1 + 60, "Controls:", c_white, 1, 0.65)
Draw_text_color_size(xx1 + 10, yy1 + 80, "Space - Toggle pause", c_white, 1, 0.65)
Draw_text_color_size(xx1 + 10, yy1 + 100, "Left click - select units, lock weapon target, power systems (HUD)", c_white, 1, 0.65)
Draw_text_color_size(xx1 + 10, yy1 + 120, "Right click - move units, unlock weapons target, un-power systems (HUD)", c_white, 1, 0.65)
Draw_text_color_size(xx1 + 10, yy1 + 140, "Numer row (1-4) - target weapons", c_white, 1, 0.65)
Draw_text_color_size(xx1 + 10, yy1 + 180, "M - toggle music", c_white, 1, 0.65)
InstanciateButton(xx2 - 180, yy1 + 180)
