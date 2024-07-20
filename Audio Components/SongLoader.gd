extends Node

var dir = OS.get_executable_path().get_base_dir()
var python_path = dir + 'Python Files/arc_env/Scripts/python.exe'
var loading_script_path = dir + 'PythonFiles/test.py'


func _ready():
	if !OS.has_feature('standalone'):	# If not an exported version
		python_path = ProjectSettings.globalize_path('res://Python Files/arc_env/Scripts/python.exe')
		loading_script_path = ProjectSettings.globalize_path('res://Python Files/read_wav.py')

	Events.load_song.connect(_load_song)


func _load_song(file_path):
	file_path = ProjectSettings.globalize_path(file_path)
	
	if !file_path.ends_with('.wav'):
		$"../AcceptDialog".popup()
		return
		
	var output = []
	var err = OS.execute(python_path, [loading_script_path, file_path], output)
	
	print(output)
	
	# Separate the sample frequency from the audio data
	output = output[0].split('-')
	var sample_freq = output[0]
	
	# Collect the data
	var audio_data_str = output[1].split(',')
	var audio_data_float: Array[float] = []
	for i in range(len(audio_data_str)):
		audio_data_float.append(float(audio_data_str[i]))

	# Normalize from 0 to 1
	var max_volume: float = audio_data_float.max()
	for i in range(len(audio_data_float)):
		audio_data_float[i] /= max_volume

	# Pass the normalized data to the visualizer component
	$"../Audio Visualizer".sample_freq = sample_freq
	$"../Audio Visualizer".audio_data = audio_data_float
	
	# Delete the choose song button
	$"../Choose Song Button".hide()
		
	# Update the global variables
	Globals.loaded_song_file_path = file_path
	
	Events.song_loaded.emit()


func _on_choose_song_button_pressed():
	$"../FileDialog".popup()
