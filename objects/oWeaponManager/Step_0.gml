if (playerTeam)
{
	for (var i = 0; i < num_weapon; i++)
	{
		if (keyboard_check_pressed(ord(i+1)))
		{
			mouse_targeting = true
			targeting_weapon_index = i
			break
		}
	}

	if (mouse_targeting)
	{
		global.neverWeaponed = false
		if (mouse_check_button_released(mb_right))
		{
			StopMouseTargeting()
			with (weapons[targeting_weapon_index])
				targeting = false
		}
		else if (mouse_check_button_released(mb_left))
		{
			StopMouseTargeting()
			var tile = instance_position(mouse_x, mouse_y, oTile)
			with (weapons[targeting_weapon_index])
			{
				if (tile != noone && tile.GetPlayerTeam() != other.playerTeam)
				{
					global.neverLockedWeapons = false
					targeting = true
					target = tile
				}
				else
				{
					targeting = false
				}
			}
		}
	}
}
else  // Not player
{
	for (var i = 0; i < num_weapon; i++)
	{
		if (weapon_deactivated_cheat)
			continue

		with (weapons[i])
		{
			if (targeting)
				continue
			
			var tile = instance_find(oTile, irandom(instance_number(oTile) - 1))
			while (tile.GetPlayerTeam() == other.playerTeam)
				tile = instance_find(oTile, irandom(instance_number(oTile) - 1))
			targeting = true
			target = tile
		}
	}
}
