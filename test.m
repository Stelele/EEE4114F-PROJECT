[signal, fs] = audioread("recordings/network/dtmfN3.wav");

figure(500);
spectrogram(signal,128,120,128,fs,'yaxis');

digits = detectDigits(signal,fs);


