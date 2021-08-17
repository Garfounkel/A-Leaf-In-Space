if (debug)
{
	draw_set_alpha(.5);
	mp_grid_draw(global.ship_grid);
	draw_set_alpha(1);
}

if (debug_path)
	draw_path(global.lastpath, x, y, true);