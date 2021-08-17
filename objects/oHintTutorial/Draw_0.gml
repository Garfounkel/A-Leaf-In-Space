if (global.neverPowered)
{
	Draw_text_color_outline(x, y, "Power your Weapons, Shields and Pilot systems (Right click)", c_white, 1, c_black, 1, 1, 20, 0.5, 0.5, 0)
	draw_arrow(x+21, y+20, x+35, y+60, 10)
}


if (global.neverWeaponed)
{
	var x1 = (room_width / 2) - 100
	var y1 = room_height - 25
	Draw_text_color_outline(x1, y1, "Start targeting with your weapons (Number row 1-2)", c_white, 1, c_black, 1, 1, 20, 0.5, 0.5, 0)
	draw_arrow(x1 - 5, y1 + 5, x1 - 50, y1-10, 10)
}

if (!global.neverWeaponed && global.neverLockedWeapons)
{
	var x1 = (room_width / 2) - 25
	var y1 = (room_height / 2) - 10
	Draw_text_color_outline(x1, y1, "Lock a weapon: start targeting (Number row 1-2), then (Left click) an enemy room", c_white, 1, c_black, 1, 1, 20, 0.5, 0.5, 0)
	draw_arrow(x1 + 300, y1 - 5, x1 + 260, y1-40, 10)
}

if (!global.neverPowered && !global.neverWeaponed && !global.neverLockedWeapons && global.neverUnpaused)
{
	var x1 = (room_width / 2) + 20
	var y1 = (room_height / 2) + 80
	Draw_text_color_outline(x1, y1, "Toggle pause (space)", c_white, 1, c_black, 1, 1, 20, 0.65, 0.65, 0)
	draw_arrow(x1 + 10, y1 + 20, x1 - 30, y1+50, 10)
}