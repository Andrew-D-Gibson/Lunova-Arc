# Script for reading a .wav file
import sys
import wave
import numpy as np


def read_wav_file(file_path):
	with wave.open(file_path, 'rb') as wav:
		num_frames = wav.getnframes()
		framerate = wav.getframerate()

		frames = wav.readframes(num_frames)
		audio_data = np.frombuffer(frames, dtype=np.int16)

	return framerate, audio_data


def main():
	args = sys.argv
	file = wave.open(args[1], 'rb')

	sample_freq = file.getframerate()
	signal_wave = file.readframes(-1)

	file.close()

	# if one channel use int16, if 2 use int32
	audio_array = np.frombuffer(signal_wave, dtype=np.int32)

	print(sample_freq, end='-')
	np.savetxt(sys.stdout, audio_array, delimiter='\n', newline=',')


if __name__ == "__main__":
	main()