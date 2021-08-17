draw_set_alpha(0.5)
Draw_rectangle_color(0, 0, room_width, room_height, c_black, false)
draw_set_alpha(1)

var x1 = round(room_width * 0.05)
var x2 = round(x1 + (room_width * 0.3))
var y1 = round(room_height * 0.1)
var y2 = round(room_height - (room_height * 0.05))

draw_rewards(x1, y1, x2, y2, rewards)

x1 = round(x2 + (room_width * 0.05))
x2 = round(room_width - (room_width * 0.05))

draw_ship_inventory(x1, y1, x2, y2, ship)


if (debug)
{
	for (i = 0; i < tabs_num; i++)
	{
		var bb = tabs_bb[i]
		Draw_rectangle_color(bb[0], bb[1], bb[2], bb[3], c_green, true)
	}
	
	if (active_tab == tab_id.Upgrade)
	{
		var bb = engine_bb
		Draw_rectangle_color(bb[0], bb[1], bb[2], bb[3], c_green, true)

		for (var i = 0; i < ship.numSystems; i++)
		{
			var bb = bb_systems_map[? ship.systems_without_engine[i]]
			Draw_rectangle_color(bb[0], bb[1], bb[2], bb[3], c_green, true)
		}
	}
}