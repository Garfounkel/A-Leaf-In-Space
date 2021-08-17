if (global.cheatcode_enabled && keyboard_check_pressed(ord("D")))
	debug = !debug


if (playerTeam)
{
	#region Power Management
	for (i = 0; i < num_systems_without_engines; i++)
	{
		var sys = systemsWithoutEngine[i]
		var bb = GetSystemBoundingBox(i, sys.maxPower, sys.system)
		if (mouse_check_button_released(mb_left) || mouse_check_button_released(mb_right))
		{
			if (point_in_rectangle(mouse_x, mouse_y, bb[0], bb[3], bb[2], bb[1]))
			{
				var powerAmount = 1
				if (sys.system == systems.shield)
					powerAmount = 2
				if (mouse_check_button_released(mb_right))
				{
					if (engineSystem.currentPower >= powerAmount && sys.currentPower < sys.maxPower
					    && sys.currentPower + powerAmount <= sys.currentHp)
					{
						sys.ChangeCurrentPower(powerAmount)
						engineSystem.currentPower -= powerAmount
						PlaySound(sndSystemEnergy)
						global.neverPowered = false
					}
				}
				else if (mouse_check_button_released(mb_left))
				{
					if (sys.currentPower > 0 && engineSystem.currentPower < engineSystem.maxPower)
					{
						sys.ChangeCurrentPower(-powerAmount)
						engineSystem.currentPower += powerAmount
						PlaySound(sndSystemEnergy)
					}
				}
			}
		}
	}
	#endregion
}
else
{
	// To simplify for now, the enemy AI doesn't manage power 
	// and we'll say each systems are always fully powered
	
	// If some systems needs to be repaired, send an available crew member
	for (i = 0; i < num_systems; i++)
	{
		var sys = id.systems[i]

		if (sys.currentHp < sys.maxPower && sys.GetNumberOfOccupants() < 1)
		{
			var freeTile = sys.GetFirstFreeTile()
			if (freeTile == noone)
				continue
			with (oCrew)
			{
				if (playerTeam == other.playerTeam && !isRepairing && !isMoving)
				{
					freeTile.MoveCrew(freeTile, id)
					break  // this breaks out of the with statement
				}
			}
		}
	}
}