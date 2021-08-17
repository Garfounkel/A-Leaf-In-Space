var rot = image_angle;

with (instance_create_depth(x, y, depth, oDoorWall_down))
{
	image_angle = rot;
}

with (instance_create_depth(x, y, depth, oDoorWall_up))
{
	image_angle = rot;
}


function DoorClicked()
{
	if (sprite_index == sDoorOpened)
	{
		sprite_index = sDoorOpening
		image_index = sprite_get_number(sDoorOpening) - 1
		image_speed = -1
	}

	if (sprite_index == sDoorClosed)
	{
		sprite_index = sDoorOpening
		image_speed = 1
	}	
}