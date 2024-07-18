extends Control


func _on_file_index_pressed(index: int) -> void:
	match index:
		5:
			_exit()
		_:
			print(index)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Exit"):
		_exit()
		

func _exit():
	get_tree().quit()
