
%[signal, fs] = audioread("recordings/network/dtmfN3.wav");
[signal, fs] = audioread("numbers/numM_3.wav");

% figure(500);
% spectrogram(signal,128,120,128,fs,'yaxis');
%values = fft(signal) / length(signal);

%plot(abs(values));

%digit = detectKeyPress(signal(800:end), fs);

digits = detectDigits(signal,fs);
[telephonesA, telephonesB, telephonesC] = classify(digits);