extends Label

@export var audio: AudioStreamPlayer

func _process(_delta):
	if !Globals.is_song_loaded:
		set_text("-:--:-- / -:--:--")
		return
		
	var current_time : String = _time_format_seconds(audio.get_playback_position())
	var end_time : String = _time_format_seconds(audio.stream.get_length())
	set_text(current_time + " / " + end_time)
	

func _time_format_seconds(time_seconds : float):
	var current_minutes: int = int(time_seconds / 60)
	var current_seconds: int = int(fmod(time_seconds, 60))
	var current_milliseconds: int = int((time_seconds - int(time_seconds)) * 100)
	
	return "%02d:%02d:%02d" % [current_minutes, current_seconds, current_milliseconds]
