if (!dead)
{
	draw_self()

	// draw HP
	if (currentHp < maxHp)
	{
		var x1 = x-(sprite_width/2)
		var x2 = x+(sprite_width/2)
		var y1 = y - (sprite_height / 2)
		var y2 = y1 - 4
		var perc = currentHp / maxHp
		var dist = abs(x1 - x2) * perc
		Draw_rectangle_color(x1, y1, x1 + dist, y2, global.color.hp, false)
		Draw_rectangle_color(x1, y1, x2, y2, c_black, true)
	}
}
else
{
	var perc = 1 - (dead_anim / dead_anim_frames)
	draw_sprite_ext(sprite_index, 0, x, y, 1, 1, image_angle, c_white, perc)
}