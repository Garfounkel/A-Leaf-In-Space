//if (sprite_index != noone)
//	draw_self()
var actualShields = currentShields < maxShields ? currentShields : maxShields
repeat(actualShields)
	draw_sprite_ext(sShield, 0, x, y, w, h, image_angle, c_white, 1)

//if (replate_animation && anim_frame < replate_animation_frames)
if (currentShields < maxShields)
{
	var perc = recharge_percentage
	draw_sprite_ext(sShield, 0, x, y, w*perc, h*perc, image_angle, c_white, 1)
}

//if (deplate_animation && anim_frame < deplate_animation_frames)
if (currentShields > maxShields)
{
	var perc = 1 - (anim_frame / deplate_animation_frames)
	draw_sprite_ext(sShield, 0, x, y, w*perc, h*perc, image_angle, c_white, 1)
}
