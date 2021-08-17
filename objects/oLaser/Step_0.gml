if (!global.gameplayPaused && !disabled)
{
	if (powered)
	{
		_shootTimer++;
	}
	else
	{
		_shootTimer = max(0, _shootTimer-1);
	}

	if (targeting)
	{
		if (reload_time_frame <= _shootTimer)
		{
			Fire()
			_shootTimer = 0	
		}
	}
}

if (global.cheatcode_enabled && keyboard_check_pressed(ord("F")))
{
	_shootTimer = reload_time_frame	
}