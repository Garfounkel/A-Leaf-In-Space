if (!hasLeftFirstBox && IsOutsideFirstBox())
{
	hasLeftFirstBox = true
	layer = layer_get_id("Managers")
	x = spawnCorner.xx
	y = spawnCorner.yy

	move_towards_point(targetPoint.xx, targetPoint.yy, fireSpeed);
	image_angle = direction
}

if (hasLeftFirstBox)
{
	if (IsOutsideScreen())
		instance_destroy(id)

	var hasEncounteredAShield = false
	var bullet = id
	if (!dodged)
	{
		with (oShield)
		{
			if (playerTeam != bullet.playerTeam)
			{
				if (position_meeting(bullet.x, bullet.y, id))
				{
					hasEncounteredAShield = true
					bullet.ComputeDodge()
					if (!bullet.dodged)
					{
						Hit(bullet.shieldDamage)
						PlaySound(sndShieldImpact)
						instance_destroy(bullet.id)
					}
				}
			}
		}
	
		if (!hasEncounteredAShield && position_meeting(targetPoint.xx, targetPoint.yy, id))
		{
			with (oShipController)
			{
				if (playerTeam != bullet.playerTeam)
				{
					bullet.ComputeDodge()
					if (!bullet.dodged)
					{
						RandomImpactSound()
						hullHp -= bullet.damage;
						bullet.target.linked_system.TakeDamage(bullet.systemDamage, bullet.crewDamage)
						if (hullHp <= 0)
							ShipDestroyed();
						bullet.image_index = 0
						bullet.alarm[0] = 1
					}
				}
			}
		
		}
	}
}