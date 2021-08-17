mouse_targeting = false
text_col = global.target_col

weapon_deactivated_cheat = false

function InitWeaponManager()
{
	num_weapon = 0
	with (oLaser)
	{
		if (playerTeam == other.playerTeam && !disabled)
		{
			other.weapons[other.num_weapon++] = id
		}
	}
}
InitWeaponManager()

function StopMouseTargeting()
{
	
	mouse_targeting = false
	cursor_sprite = sCursor32x32
}

function AllocatePower(powerAmount)
{
	for (var i = 0; i < num_weapon; i++)
	{
		if (powerAmount >= weapons[i].reqPower)
		{
			weapons[i].powered = true
			powerAmount -= weapons[i].reqPower
		}
		else
		{
			weapons[i].powered = false
		}
	}
}
