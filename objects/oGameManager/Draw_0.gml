if (display_debug)
{
	draw_text_transformed(room_width - 100, 10, "FPS Real: " + string(fps_real), 0.5, 0.5, 0);
	draw_text_transformed(room_width - 100, 20, "FPS: " + string(fps), 0.5, 0.5, 0);
	draw_text_transformed(room_width - 100, 30, "Selected: " + string(global.numberSelected), 0.5, 0.5, 0);
}

if (global.gameplayPaused)
{
	draw_set_halign(fa_center);
	draw_text_transformed_colour(room_width / 2, round(room_height*0.75), "PAUSED", 2, 2, 0, c_aqua, c_aqua, c_aqua, c_aqua, 1);
	draw_set_halign(fa_left);
}

//if (paused && screen_copied)
//{
//	draw_sprite_ext(pause_sprite, 0, 
//					floor(camera_get_view_x(view_camera[0])), floor(camera_get_view_y(view_camera[0])),
//					wScreenRatio, hScreenRatio, 0, c_white, 1)
	
//	draw_set_alpha(0.5)
//	draw_rectangle_colour(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
//	draw_set_alpha(1);
//	draw_set_halign(fa_center);
//	draw_text_transformed_colour(room_width / 2, room_height / 2, "PAUSED", 2, 2, 0, c_aqua, c_aqua, c_aqua, c_aqua, 1);
//	draw_set_halign(fa_left);
//}
