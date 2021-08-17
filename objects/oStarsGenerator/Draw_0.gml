for (i=0; i<stars_amount ; i++) {
	if (i == stars_amount - 1)  // Planet code
	{
		xx = (ds_grid_get(stars,0,i) + anim_amount * sprites[i].speed * 0.5)
	    yy = (ds_grid_get(stars,1,i) + anim_amount * sprites[i].speed * 0.5)
	}
	else
	{
	    xx = (ds_grid_get(stars,0,i) + anim_amount * sprites[i].speed * 0.5) % (room_width + 200) - 100
	    yy = (ds_grid_get(stars,1,i) + anim_amount * sprites[i].speed * 0.5) % (room_height + 200) - 100
	}
	draw_sprite_ext(sprites[i].sprite, 0, xx, yy, 
					sprites[i].size, sprites[i].size, sprites[i].rot, 
					sprites[i].col, sprites[i].alpha)
}

//anim_inc++;
//if (anim_inc % 100 == 0)
anim_amount += 0.3;