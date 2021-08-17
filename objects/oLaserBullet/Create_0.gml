target = noone
fireSpeed = 5
hasLeftFirstBox = false
dodged = false

targetPoint = new point(infinity,infinity)
spawnCorner = new point(infinity,infinity)
damage = 0
systemDamage = 0

function IsOutsideScreen()
{
	return (x < (0 - sprite_width)) ||
		   (x > (room_width + sprite_width)) ||
		   (y > (room_height + sprite_height)) ||
		   (y < (0 - sprite_height))	
}

function IsOutsideFirstBox()
{
	if (playerTeam)
		return IsOutsideScreen()
	else
	{
		var x1 = oEnemyFrame.x
		var y1 = oEnemyFrame.y
		var x2 = x1 + oEnemyFrame.sprite_width
		var y2 = y1 + oEnemyFrame.sprite_height
		return (x < (x1 + sprite_width)) ||
			   (x > (x2 - sprite_width)) ||
			   (y > (y2 - sprite_height)) ||
			   (y < (y1 + sprite_height))
	}
}

function ComputeDodge(level)
{
	var bullet = id
	with (oShipController)
	{
		if (playerTeam != bullet.playerTeam)
		{
			if (random(1) < GetDodgeChance())
			{
				bullet.dodged = true
				instance_create_layer(bullet.x, bullet.y, "Managers", oMiss)
			}
		}
	}	
}
