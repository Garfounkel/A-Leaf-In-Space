if (!global.gameplayPaused)
{
	if (currentShields < maxShields)  // Replenish shields
	{
		anim_frame++
		if (replate_pause)
		{
			if (anim_frame >= pause_frames)
			{
				PlaySound(sndShieldBack)
				replate_pause = false
				anim_frame = 0
			}
		}
		else
		{
			if (anim_frame >= replate_animation_frames)
				GainOneShield()
			else
				recharge_percentage = anim_frame / replate_animation_frames
		}
	}
	else if (currentShields > maxShields)  // Deplate shields
	{
		anim_frame++
		if (anim_frame >= deplate_animation_frames)
		{
			currentShields--
			UpdateDecreasedShields()
		}
	}
}
