function ColorHolder(hpBgColor, hpColor, shieldColor, systemAbrevColor, systemDestroyedColor, systemDamagedColor) constructor
{
	hpBg = hpBgColor
	hp = hpColor
	shield = shieldColor
	systemAbrev = systemAbrevColor
	systemDestroyed = systemDestroyedColor
	systemDamaged = systemDamagedColor
}

global.color = new ColorHolder(hpBgColor, hpColor, shieldColor, 
							   systemAbrevColor, 
							   systemDestroyedColor, systemDamagedColor)