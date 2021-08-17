playingAudio = false

musicToggled = true

global.sfxLoaded = false

audio_group_load(agSfx)

music_gain = 0.3

any_click_registered = false
any_key_registered = false

function TryPlayMusic()
{
	if (!playingAudio && any_key_registered && any_click_registered)
	{
		music = audio_play_sound(mBackground, 1000, true)
		audio_sound_gain(music, music_gain, 0)
		playingAudio = true
	}
}