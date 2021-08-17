draw_self()

draw_text_transformed_color(x+5, y-1, "UFO TARGET", UI_titlesize, UI_titlesize, 
							0, c_white, c_white, c_white, c_white, 0.5)

function GetRandomCorner()
{
	xx = choose(x, x + sprite_width)
	yy = choose(y, y + sprite_height)
	return new point(xx, yy)
}
