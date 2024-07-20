import sys
import wave
import pyaudio
import numpy as np
import matplotlib.pyplot as plt

args = sys.argv
file = wave.open(args[1], 'rb')

sample_freq = file.getframerate()
frames = file.getnframes()
signal_wave = file.readframes(-1)

file.close()

time = frames / sample_freq


# if one channel use int16, if 2 use int32
audio_array = np.frombuffer(signal_wave, dtype=np.int32)

times = np.linspace(0, time, num=frames)

plt.figure(figsize=(15, 5))
plt.plot(times, audio_array)
plt.ylabel('Signal Wave')
plt.xlabel('Time (s)')
plt.xlim(0, time)
plt.show()