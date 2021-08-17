if (playerTeam)
{
	if (mouse_targeting)
	{
		cursor_sprite = sTarget24
		draw_text_transformed_color(round(mouse_x+4), round(mouse_y+3), string(targeting_weapon_index+1), 
									0.75, 0.75, 0, text_col, text_col, text_col, text_col, 1)
	}

	// Draw targets
	for (var i = 0; i < num_weapon; i++)
	{
		with (weapons[i])
		{
			var c = other.text_col
			if (targeting)
			{
				var pos = target.linked_system.GetCenterPoint();
				draw_sprite_ext(sTarget24, 0, 
								pos.xx, pos.yy,
								1, 1, 0, c_white, 1)
				draw_text_transformed_color(round(pos.xx + 8), round(pos.yy + 8),
											i+1, 0.75, 0.75, 0, 
											c, c, c, c, 1)
			}
			// Draw numbers
		    draw_text_transformed_color(x, y, string(i+1), 0.65, 0.65, 0, c_white, c_white, c_white, c_white, 1)
		}
	}
}
