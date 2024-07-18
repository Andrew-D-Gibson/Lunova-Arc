extends AudioStreamPlayer

func _ready():
	Events.song_loaded.connect(_set_song_stream)
	Events.toggle_playing.connect(_on_toggle_playing)
	

func load_mp3(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound


func _set_song_stream():
	if Globals.is_song_loaded:
		var song = load_mp3(Globals.loaded_song_file_path)

		set_stream(song)
		play()	# Necessary to start the music the first time
		
		# Immediately pause the music to let the user start as desired
		stream_paused = true
		Globals.playing = false
		
		Events.update_ui.emit()
		
		
func _on_toggle_playing():
	if get_stream() != null:
		stream_paused = !stream_paused
		Globals.playing = !stream_paused
		Events.update_ui.emit()
	
