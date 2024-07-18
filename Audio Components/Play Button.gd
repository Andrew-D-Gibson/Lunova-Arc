extends Button

@onready var play_icon := preload("res://UI Icons/play.svg")
@onready var pause_icon := preload("res://UI Icons/pause.svg")

func _ready():
	Events.update_ui.connect(_update_ui)
	
	
func _toggle_playing():
	Events.toggle_playing.emit()


func _update_ui():
	if Globals.playing:
		icon = pause_icon
	else:
		icon = play_icon
		
