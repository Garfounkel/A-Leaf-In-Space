if (playingAudio)
{
	musicToggled = !musicToggled
	if (musicToggled)
		audio_sound_gain(music, music_gain, 0)
	else
		audio_sound_gain(music, 0, 0)
}