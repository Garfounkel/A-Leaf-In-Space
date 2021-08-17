draw_self()

draw_text_transformed_color(x + 5, y + sprite_height - 18, "WEAPONS",
							UI_titlesize, UI_titlesize, 0, 
							c_black, c_black, c_black, c_black, 0.5)

with (oWeaponManager)
{
	if (!playerTeam)
		break
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	var tsize = 0.65
	var tsize_num = 0.45
	var c1 = c_white
	var c2 = global.target_col
	var reqPowSize = 6
	for (var i = 0; i < num_weapon; i++) {
		var x_centered = other.x + (other.weapon_slot_size_x*i) + (other.weapon_slot_size_x / 2)
		var c = c1
		if (mouse_targeting && i == targeting_weapon_index)
			c = c2
		var ext = "..."
		if (weapons[i].level > 0)
			ext = "..." + string(weapons[i].level)
		var weap_name = string_limit_width(weapons[i].weapon_name, 70, ext)
		draw_text_transformed_color(x_centered + reqPowSize, other.y + 8, weap_name,
									tsize, tsize, 0, c, c, c, c, 1)
		var text = string(i+1)
		if (weapons[i].targeting)
			text += " A"
		draw_text_transformed_color(x_centered + other.weapon_slot_size_x / 3, 
									other.y + other.sprite_height / 2, text,
									tsize_num, tsize_num, 0, c, c, c, c, 1)
		
		// Draw req power
		j = 0
		var offset = 7
		repeat(weapons[i].reqPower)
		{
			var x1 = round(other.x + (other.weapon_slot_size_x*i) + 12 + (offset * j))
			var x2 = x1 + reqPowSize
			var y1 = round(other.y + (other.sprite_height * 0.6))
			var y2 = y1 - reqPowSize
			if (weapons[i].powered)
				Draw_rectangle_color(x1, y1, x2, y2, global.color.hp, false)
			Draw_rectangle_color(x1, y1, x2, y2, global.color.hpBg, true)
			j++
		}
		
		// Draw charge level
		var x1 = other.x + (other.weapon_slot_size_x*i) + 5
		var x2 = x1 + 3
		var y1 = round(other.y + (other.sprite_height * 0.6))
		var y2 = round(other.y + (other.sprite_height * 0.05))
		var dist = abs(y1 - y2) * weapons[i].GetChargePerc()
		draw_rectangle_color(x1, y1, x2, y1 - dist, c2, c2, c2, c2, false)
		draw_rectangle_color(x1, y1, x2, y2, c_white, c_white, c_white, c_white, true)
	}
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}
