window_set_cursor(cr_none)
cursor_sprite = sCursor32x32
randomize()
global.base_money = 100

global.highscore = 0
global.difficulty = 1
global.numberSelected = 0
global.money = global.base_money
global.neverPowered = true
global.neverWeaponed = true
global.neverUnpaused = true
global.neverLockedWeapons = true

global.cheatcode_enabled = false

base_width = room_width;
base_height = room_height;
width = base_width;
height = base_height;

display_debug = false;
global.textId = new TextId()

full_paused = false
global.gameplayPaused = false
pause_sprite = noone
screen_copied = false
wScreenRatio = camera_get_view_width(view_camera[0]) / view_wport[0]
hScreenRatio = camera_get_view_height(view_camera[0]) / view_hport[0]

unique_id = 0

function Pause()
{
	global.gameplayPaused = true
	screen_copied = false
	with (all)
	{
		gamePausedImageSpeed = image_speed
		image_speed = 0
		gamePausedSpeed = speed
		speed = 0
	}
}

function Unpause()
{
	if (global.neverPowered || global.neverWeaponed || global.neverLockedWeapons)
		return;

	global.neverUnpaused = false
	global.gameplayPaused = false
	with (all)
	{
		if (variable_instance_exists(id, "gamePausedImageSpeed"))
			image_speed = gamePausedImageSpeed
		if (variable_instance_exists(id, "gamePausedSpeed"))
			speed = gamePausedSpeed
	}
}

Pause()
