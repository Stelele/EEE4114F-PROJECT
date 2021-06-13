N = 512;
fs = 8000;
f1 = 1209;
f2 = 697;
k = 0:255;

dt = 1/fs;
t = 0:dt:1;

sig = sin(2*pi*f1*t) + sin(2*pi*f2*t);

x = zeros(1,N);

x(1:N/2) = sig(1:N/2);

val = detectKeyPress(x, fs);
