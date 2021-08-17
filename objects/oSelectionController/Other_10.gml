var x1 = min(select_x1, select_x2);
var y1 = min(select_y1, select_y2);
var x2 = max(select_x1, select_x2);
var y2 = max(select_y1, select_y2);

with (oCrew)
{
	if (collision_rectangle(x1, y1, x2, y2, id, false, false))
	{
		id.Select();
	}
	else
	{
		if (!keyboard_check(vk_shift))
		{
			id.Deselect();
		}
	}
}