var cx = camera_get_view_x(view_camera[0])
var cy = camera_get_view_y(view_camera[0])

if (shake)
{
	xx = cx + random_range(-shake_amount, shake_amount)
	yy = cy + random_range(-shake_amount, shake_amount)
	camera_set_view_pos(view_camera[0], xx, yy)
}
else
{
	var cxx = 0
	var cyy = 0

	if (cx < 0)
		cxx = 1;
	if (cx > 0)
		cxx = -1;
	if (cy < 0)
		cyy = 1;
	if (cy > 0)
		cyy = -1;
		
	if (cxx != 0 || cyy != 0)
		camera_set_view_pos(view_camera[0], floor(cx + cxx), floor(cy + cyy))
}