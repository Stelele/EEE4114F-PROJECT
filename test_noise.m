%{
    This script can be used to test the dtmf deconder under the presence of
    noise
%}

% Almost noise free
generate(['0','1','2','3','4','5','6','7','8','9','A','B','C','D','*','#'], 500, -200 ,'numbers/noise_free.wav');
[signal0, fs] = audioread("numbers/noise_free.wav");
% figure(50);
% spectrogram(signal0,128,120,128,fs,'yaxis');

digits0 = detectDigits(signal0,fs);
disp("Noise Free");
disp(digits0');

% Moderate Noise
generate(['0','1','2','3','4','5','6','7','8','9','A','B','C','D','*','#'], 500, -10 ,'numbers/noise_-10dbm.wav');
[signal1, fs] = audioread("numbers/noise_-10dbm.wav");
% figure(500);
% spectrogram(signal1,128,120,128,fs,'yaxis');

digits1 = detectDigits(signal1,fs);
disp("-10dbm Noise");
disp(digits1')

% Threshold noise
generate(['0','1','2','3','4','5','6','7','8','9','A','B','C','D','*','#'], 500, 0 ,'numbers/noise_0dbm.wav');
[signal2, fs] = audioread("numbers/noise_0dbm.wav");
% figure(500);
% spectrogram(signal2,128,120,128,fs,'yaxis');

digits2 = detectDigits(signal2,fs);
disp("0dbm Noise");
disp(digits2')

% High noise
generate(['0','1','2','3','4','5','6','7','8','9','A','B','C','D','*','#'], 500, 10 ,'numbers/noise_10dbm.wav');
[signal3, fs] = audioread("numbers/noise_10dbm.wav");
% figure(500);
% spectrogram(signal3,128,120,128,fs,'yaxis');

digits3 = detectDigits(signal3,fs);
disp("10dbm Noise");
disp(digits3')

