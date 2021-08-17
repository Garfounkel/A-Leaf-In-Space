function Draw_rectangle_color(x1, y1, x2, y2, color, outline)
{
	draw_rectangle_color(x1, y1, x2, y2, color, color, color, color, outline)
}


//By Blokatt - @blokatt, blokatt.net
function Draw_text_color_outline(x, y, text, textColor, textAlpha, outlineColor, outlineAlpha, outlineThickness, outlineQuality, xscale, yscale, angle) 
{
	var i;
	for (i = 0; i < 360; i += 360 / outlineQuality){
	    draw_text_transformed_color(x + lengthdir_x(outlineThickness, i), y + lengthdir_y(outlineThickness, i), string(text), xscale, yscale, angle, outlineColor, outlineColor, outlineColor, outlineColor, outlineAlpha);
	}
	draw_text_transformed_color(x, y, string(text), xscale, xscale, angle, textColor, textColor, textColor, textColor, textAlpha);
}


function Draw_text_color(x, y, text, color, alpha)
{
	draw_text_color(x, y, text, color, color, color, color, alpha)
}

function Draw_text_color_size(x, y, text, color, alpha, size)
{
	draw_text_transformed_color(x, y, text, size, size, 0, color, color, color, color, alpha)	
}

function Draw_text_color_centered(x, y, text, color, alpha)
{
	DrawCenterOn()
	Draw_text_color(x, y, text, color, alpha)
	DrawCenterOff()
}

function Draw_text_color_size_centered(x, y, text, color, alpha, size)
{
	DrawCenterOn()
	Draw_text_color_size(x, y, text, color, alpha, size)
	DrawCenterOff()
}

function Draw_text_centered(x, y, text)
{
	DrawCenterOn()	
	draw_text(x, y, text)
	DrawCenterOff()
}