function point(xxx, yyy) constructor
{
	xx = xxx;
	yy = yyy;
}

function ComputePath(path, pathPoints, start_x, start_y, end_x, end_y){
	if (!mp_grid_path(global.ship_grid, path, start_x, start_y, end_x, end_y, true))
	{
		print("No path");
		return false;
	}
	else
	{
		path_set_kind(path, 0);
		global.lastpath = path;
		var centeredPath = path_add();
		path_set_kind(centeredPath, 0);
		path_set_closed(centeredPath, false);
		
		var lastPoint_x = infinity;
		var lastPoint_y = infinity;
		
		ds_list_clear(pathPoints);

		for (var i = 0; i < path_get_number(path); ++i) {
			var xx = roundUp(path_get_point_x(path, i), cellsize) - (cellsize/2);
			var yy = roundUp(path_get_point_y(path, i), cellsize) - (cellsize/2);
			if (xx != lastPoint_x || yy != lastPoint_y)
			{
				path_add_point(centeredPath, xx, yy, 100);
				ds_list_add(pathPoints, new point(xx, yy))
				lastPoint_x = xx;
				lastPoint_y = yy;
			}
		}
		path_assign(path, centeredPath);
		return true;
	}
}