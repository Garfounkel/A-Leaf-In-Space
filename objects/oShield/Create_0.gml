//replate_animation = false
replate_animation_frames = 30
//deplate_animation = false
deplate_animation_frames = 10
anim_frame = 0
pause_frames = 60
recharge_percentage = 1
replate_pause = false
w = image_xscale
h = image_yscale

maxShields = 0
currentShields = maxShields
sprite_index = noone

function Hit(shieldDamage)
{
	currentShields = max(currentShields - shieldDamage, 0)
	UpdateDecreasedShields()
	replate_pause = true
}

function UpdateDecreasedShields()
{
	anim_frame = 0
	recharge_percentage = 0
	if (currentShields == 0)
		sprite_index = noone
}

function GainOneShield()
{
	if (currentShields >= maxShields)
	{
		return
	}
	currentShields++
	if (sprite_index == noone)
		sprite_index = sShield
	recharge_percentage = 1
	replate_pause = currentShields < maxShields
	anim_frame = 0
}

function SetMaxShields(_maxShields)
{
	if (_maxShields < maxShields)
	{
		anim_frame = 0
		recharge_percentage = 0
	}
	maxShields = _maxShields
}

function RefreshAllShields()
{
	currentShields = maxShields
	if (currentShields > 0)
		sprite_index = sShield
}
