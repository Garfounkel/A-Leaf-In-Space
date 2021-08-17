function GetSystemHpColor(system, issForAbrev)
{
	var bgcol = c_white
	if (issForAbrev)
		bgcol = global.color.systemAbrev

	if (system.currentHp == 0)
		bgcol = global.color.systemDestroyed
	else if (system.currentHp < system.maxPower)
		bgcol = global.color.systemDamaged
	else if (!issForAbrev && system.currentPower > 0)
		bgcol = global.color.hp
	return bgcol
}