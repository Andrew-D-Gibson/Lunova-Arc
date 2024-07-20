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
	assert(Globals.loaded_song_file_path != "")
		
	var song = load(Globals.loaded_song_file_path)

	set_stream(song)
	play()	# Necessary to start the music the first time
	
	# Immediately pause the music to let the user start as desired
	stream_paused = true
	Globals.playing = false
	Globals.is_song_loaded = true
	
	Events.update_ui.emit()
		
		
func _on_toggle_playing():
	if get_stream() != null:
		stream_paused = !stream_paused	# Toggle the stream 
		Globals.playing = !stream_paused	# Set the Global "playing" value to the opposite
		Events.update_ui.emit()
	

func _on_finished():
	pass
