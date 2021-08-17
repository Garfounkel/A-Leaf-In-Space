hovered = false
upgradeButton = false

continueButton = false
nextRoomButton = false

w = round(sprite_width * 1.5)
h = sprite_height
image_xscale = 1.5

parent_frame = id

function Clicked()
{
	PlayMouseClickSound()
	if (continueButton)
	{
		if (nextRoomButton)
			room_goto_next()
		else
		{
			instance_create_layer(0, 0, "Popupframe", oTutorial)
			if (parent_frame != id)
				instance_destroy(parent_frame)
			instance_destroy(id)
		}
	}
	else if (upgradeButton)
	{
		with (oShipController)
		{
			if (playerTeam)
				Rewards()
		}
		if (parent_frame != id)
			instance_destroy(parent_frame)
		instance_destroy(id)
	}
	else
	{
		global.money = global.base_money
		room_restart()
	}
}