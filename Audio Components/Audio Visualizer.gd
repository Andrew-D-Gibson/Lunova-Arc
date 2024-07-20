extends Node2D

@export var audio_stream_player: AudioStreamPlayer

var audio_data: Array[float] = []
var sample_freq: int

var time_interval_to_show: float = 5

func _draw():
	# Only draw a visual if the song is loaded
	if !Globals.is_song_loaded:
		return
	assert(audio_data != [])
	
	# Check the size the visualizer is drawing within
	var panel_width: int = get_parent().size.x
	var panel_height: int = get_parent().size.y
	
	var rectangles_to_show = 100 #time_interval_to_show * sample_freq
	
	var rect_width = panel_width / rectangles_to_show
	
	
	var playback_proportion: float = audio_stream_player.get_playback_position() / audio_stream_player.stream.get_length()
	var current_index: int = floor(playback_proportion * len(audio_data))

	for i in range(rectangles_to_show):
		draw_rect(
			Rect2(rect_width * i, 0, rect_width, panel_height * audio_data[current_index + i]),
			Color(0.75, 0.75, 0.75)
		)
		#draw_line(
				#Vector2(w * i, HEIGHT - height),
				#Vector2(w * i + w - 2, HEIGHT - height),
				#Color.from_hsv(float(VU_COUNT * 0.6 + i * 0.5) / VU_COUNT, 0.5, 1.0),
				#2.0,
				#true
		#)

func _process(delta: float) -> void:
	queue_redraw()
