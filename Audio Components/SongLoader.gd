extends Node

var dir = OS.get_executable_path().get_base_dir()
var python_path = dir + 'Python Files/arc_env/Scripts/python.exe'
var loading_script_path = dir + 'PythonFiles/test.py'


func _ready():
	if !OS.has_feature('standalone'):	# If not an exported version
		python_path = ProjectSettings.globalize_path('res://Python Files/arc_env/Scripts/python.exe')
		loading_script_path = ProjectSettings.globalize_path('res://Python Files/test.py')

	Events.load_song.connect(_load_song)


func _load_song(file_path):
	file_path = ProjectSettings.globalize_path(file_path)
	var output = []
	var err = OS.execute(python_path, [loading_script_path, file_path], output)
	
	output = output[0].split('-')

	if output[0] == 'wav':
		pass
	elif output[0] == 'mp3':
		pass
	else:
		$"../AcceptDialog".popup()
		return
		
	# Collect the data
	var file_type = output[0]
	var rate = output[1]
	var audio_data_str = output[2].split(',')
	
	var audio_data_float = []
	for i in range(len(audio_data_str)):
		audio_data_float.append( float(audio_data_str[i]) )
	
	print(audio_data_float.max())
	
		
	# Update the global variables
	Globals.is_song_loaded = true
	Globals.loaded_song_file_path = file_path
	
	Events.song_loaded.emit()


func _on_choose_song_button_pressed():
	$"../FileDialog".popup()
