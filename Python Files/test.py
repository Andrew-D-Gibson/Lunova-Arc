import sys
import wave
import librosa
import numpy as np


def read_wav_file(file_path):
    with wave.open(file_path, 'rb') as wav:
        num_frames = wav.getnframes()
        framerate = wav.getframerate()

        frames = wav.readframes(num_frames)
        audio_data = np.frombuffer(frames, dtype=np.int16)

    return framerate, audio_data


if __name__ == "__main__":
    args = sys.argv  

    if args[1].endswith('.wav'):
        framerate, audio_data = read_wav_file(args[1])
        print('wav', end='-')
        print(framerate, end='-')
        print(audio_data, end='-')

    elif args[1].endswith('.mp3'):
        audio_data, sampling_rate = librosa.load(args[1], sr=None)
        print('mp3', end='-')
        print(sampling_rate, end='-')
        np.savetxt(sys.stdout, audio_data, delimiter='\n', newline=',') #fmt='%d' ensures integers are printed

    else:
        print('Unsupported file type.', end='')

    #np.savetxt(sys.stdout, my_array, delimiter=',', fmt='%d') #fmt='%d' ensures integers are printed