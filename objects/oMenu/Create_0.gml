x1 = 0
y1 = 0
x2 = room_width
y2 = room_height
center = get_center(x1, y1, x2, y2)

creditText = "Programming and Art - Simon Andersen\nMusic and Sound design - Zenibuka"


anim_frame = 0
max_anim_frame = 30

instanciated_button = false

function InstanciateButton(xx, yy)
{
	if (instanciated_button)
		return;
	
	instanciated_button = true
	with (instance_create_layer(xx, yy, "ButtonLayer", oRestartButton))
	{
		//depth = frameDepth - 1
		upgradeButton = false
		continueButton = true
		parent_frame = other.id
	}
}
