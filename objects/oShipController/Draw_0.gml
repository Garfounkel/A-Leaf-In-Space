var i = 0
var offset = 9
var size = 4
//draw_text_transformed_color(round(x + 10), yy, "HULL HP", 0.5, 0.5, 0, c_white, c_white, c_white, c_white, 1)
repeat(maxHullHp)
{
	var xx = round(UI_x1 + (offset*i))
	var yy = UI_y1
	var x1 = xx - size
	var y1 = yy - size
	var x2 = xx + size
	var y2 = yy + size
	if (i < hullHp)
		Draw_rectangle_color(x1, y1, x2, y2, global.color.hp, false)
	Draw_rectangle_color(x1, y1, x2, y2, global.color.hpBg, true)
	i++
}

#region Shields
if (hasShields)
{
	i = 0
	repeat(shieldSystem.maxPower div 2)
	{
		var xx = round(UI_x1 + (offset*i))
		var yy = UI_y1 + (size * 2 + 4)
		var x1 = xx - size
		var y1 = yy - size
		var x2 = xx + size
		var y2 = yy + size
		if (i < shieldController.currentShields)
			Draw_rectangle_color(x1, y1, x2, y2, global.color.shield, false)
		Draw_rectangle_color(x1, y1, x2, y2, global.color.hpBg, true)
		i++
	}

	if (shieldController.recharge_percentage > 0 && shieldController.recharge_percentage < 1)
	{
		var xx = round(UI_x1) - size
		var yy = UI_y1 + (size*4 + 4)
		var maxsize = 40
		var cursize = (maxsize * shieldController.recharge_percentage)
		Draw_rectangle_color(xx, yy, xx + cursize, yy+3, global.color.shield, false)
		Draw_rectangle_color(xx, yy, xx + maxsize, yy+3, global.color.hpBg, true)
	}
}
#endregion

#region Power
i = 0
var xx = round(UI_xbottom) - size
var yy = round(UI_y2) - 12
var bgcol = GetSystemHpColor(engineSystem, false)
draw_sprite_ext(sSystemBg, 0, xx - 4, yy - 4, 1, 1, 0, bgcol, 1)
Draw_text_color_outline(xx+1, yy-2, engineSystem.abrev, global.color.systemAbrev, 1, c_black, 1, 1, 10, 0.65, 0.65, 0)
yy -= 16
if (playerTeam || debug)
{
	repeat(engineSystem.maxPower)
	{
		var x1 = xx
		var y1 = yy - (sys_y_offset * i)
		var x2 = x1 + sys_size_x
		var y2 = y1 + sys_size_y
		if (i < engineSystem.currentPower)
			Draw_rectangle_color(x1, y1, x2, y2, global.color.hp, false)
		Draw_rectangle_color(x1, y1, x2, y2, global.color.hpBg, true)
		i++
	}
}
#endregion

#region Systems
for (i = 0; i < num_systems_without_engines; i++)
{
	var sys = systemsWithoutEngine[i]
	var xx = round(UI_xbottom) + 48 + (sys_x_offset*i)
	if (!playerTeam)
		xx -= 20
	var yy = round(UI_y2) - 12
	var bgcol = GetSystemHpColor(sys, false)
	draw_sprite_ext(sSystemBg, 0, xx - 4, yy - 4, 1, 1, 0, bgcol, 1)
	Draw_text_color_outline(xx+1, yy-2, sys.abrev, global.color.systemAbrev, 1, c_black, 1, 1, 10, 0.65, 0.65, 0)
	if (sys.driven)
		Draw_text_color_size(xx, yy+16, "driv", global.target_col, 1, 0.5)
	//draw_sprite_ext(sys.sprite, 0, xx, yy, 1, 1, 0, c_white, 1)
	if (playerTeam || debug)
	{
		var j = 0
		yy -= 16
		repeat (sys.maxPower)
		{
			var x1 = xx
			var y1 = yy - (sys_y_offset * j)
			var x2 = x1 + sys_size_x
			var y2 = y1 + sys_size_y

			if (sys.system == systems.shield)
			{
				var empty_slots = j div 2
				y1 -= (sys_y_offset * empty_slots)
				y2 = y1 + sys_size_y
			}

			if (j < sys.currentPower)
				Draw_rectangle_color(x1, y1, x2, y2, global.color.hp, false)
			if (j+1 > sys.currentHp)
			{
				draw_set_alpha(0.2)
				Draw_rectangle_color(x1, y1, x2, y2, global.color.systemDestroyed, false)
				draw_set_alpha(1)
				if (sys.repaired_perc > 0 && j == sys.currentHp)
				{
					var dist = abs(x1 - x2) * (sys.repaired_perc/100)
					Draw_rectangle_color(x1, y1, x1 + dist, y2, global.color.systemDamaged, false)
				}
				Draw_rectangle_color(x1, y1, x2, y2, global.color.systemDestroyed, true)
			}
			else
				Draw_rectangle_color(x1, y1, x2, y2, global.color.hpBg, true)
			j++
		}
		
		if (debug)
		{
			// Draw current hp
			//draw_text_transformed(xx, yy + 32, string(sys.currentHp), 0.65, 0.65, 0)

			// Draw dodge chances
			if (sys.system == systems.pilot)
			{
				draw_text_transformed(xx, yy - (sys_y_offset * (j+2)), string(GetDodgeChance()), 0.65, 0.65, 0)
			}

			// Draw bounding box for debug
			if (playerTeam)
			{
				var bb = GetSystemBoundingBox(i, sys.maxPower, sys.system)
				Draw_rectangle_color(bb[0], bb[1], bb[2], bb[3], make_color_rgb(183, 224, 31), true)
			}
		}

	}
}
#endregion

