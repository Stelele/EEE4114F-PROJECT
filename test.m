
[signal, fs] = audioread("recordings/network/dtmfN2.wav");

%{
f1 = 697;
f2 = 1336;

fs = 8000;
dt = 1/fs;
t  = 0:dt:2;

signal = 1e-3 * sin(2*pi*f1*t) + 1e-3 * sin(2*pi*f2*t);
%}

figure(500);
spectrogram(signal,128,120,128,fs,'yaxis');
%values = fft(signal) / length(signal);

%plot(abs(values));

%digit = detectKeyPress(signal(800:end), fs);

digits = detectDigits(signal,fs);


