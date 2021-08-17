//if (browser_width != width || browser_height != height)
//{
//	width = min(base_width, browser_width);
//	height = min(base_height, browser_height);
//	scale_canvas(base_width, base_height, width, height, true);
//}

if (global.cheatcode_enabled && keyboard_check_pressed(vk_tab))
	display_debug = !display_debug
	

if (!global.rewardScreenOn && keyboard_check_pressed(vk_space))
{
	if (global.gameplayPaused)
		Unpause()
	else
		Pause()
}


if (!global.cheatcode_enabled &&
    keyboard_check_direct(vk_alt) &&
	keyboard_check_direct(vk_control) &&
	keyboard_check_direct(vk_shift) &&
	keyboard_check_direct(ord("C")))
{
	print("Cheatcodes enabled")
	global.cheatcode_enabled = true
}