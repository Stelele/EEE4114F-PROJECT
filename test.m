N = 512;
fs = 8000;
f = 1477;
k = 1:N;

dt = 1/fs;
t = 0:dt:1;

sig = sin(2*pi*f*t);

x = zeros(1,N);

x(1:N/2) = sig(1:N/2);


X = mygoertzel(x, k, N);

plot(k, 20*log(abs(X)))
