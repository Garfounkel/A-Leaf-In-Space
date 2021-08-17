if (!global.gameplayPaused)
{
	if (isMoving)
	{
		if (distance_to_point(target_x, target_y) < speedWalk)
		{
			path_pos++;
			if (path_pos >= ds_list_size(pathPoints))
			{
				isMoving = false;
				sprite_index = sHuman_static
				speed = 0;
				x = target_x;
				y = target_y;
				image_angle = 0;
			}
			else
			{
				MoveToNextPoint();
			}
		}
	}
	else
	{
		if (!dead && occupyingTile != noone)
		{
			if (occupyingTile.linked_system.system != systems.empty)
			{
				isRepairing = occupyingTile.linked_system.currentHp < occupyingTile.linked_system.maxPower
				if (isRepairing)
				{  // Repair
					occupyingTile.linked_system.Repair(repairPower / 60)
					sprite_index = sHuman_repairing
				}
				else if (!occupyingTile.linked_system.driven)
				{  // Drive
					occupyingTile.linked_system.driven = true
					occupyingTile.linked_system.driver = id
					sprite_index = sHuman_driving_start
				}
				else if (sprite_index == sHuman_repairing)
				{
					sprite_index = sHuman_static
				}
			}
		}
	}

	if (saved_MoveToNextPoint)
	{
		saved_MoveToNextPoint = false
		MoveToNextPoint()
	}

	if (dead)
	{
		dead_anim++
		if (dead_anim >= dead_anim_frames)
			instance_destroy(id)
	}
}