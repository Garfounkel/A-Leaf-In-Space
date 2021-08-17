function PlaySound(sound)
{
	if (global.sfxLoaded)
		audio_play_sound(sound, 1, false)
}

function PlayRandomSound(sounds, num_sounds)
{
	sound_index = irandom(num_sounds-1)
	PlaySound(sounds[sound_index])
}


function RandomLaserSound(player)
{
	if (player)
	{
		sounds = [sndLaserPlayer_01, sndLaserEnemy_01, sndLaserEnemy_02]
		PlayRandomSound(sounds, 3)
	}
	else
	{
		sounds = [sndLaserEnemy_01, sndLaserEnemy_02]
		PlayRandomSound(sounds, 2)
	}
}

function RandomImpactSound()
{
	sounds = [sndImpact_01, sndImpact_02, sndImpact_03]
	PlayRandomSound(sounds, 3)
}


function PlayMouseClickSound()
{
	PlaySound(sndMouseClick_01)
}

function PlayMouseHoverSound()
{
	PlaySound(sndMouseHover_02)
}