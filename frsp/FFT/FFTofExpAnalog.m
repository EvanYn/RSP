clear; clc; close all;
%%
fs = 1000;
ts = 1/fs;

f0 = 50;
N = 1000;

t = (0:N-1)*ts;
x = exp(1j*2*pi*f0*t);

K = 2^nextpow2(N);
X = fftshift(fft(x,K)/K);
f = ((0:K-1)/K - 1/2)*fs;

figure(1)
stem(f,abs(X))
vline(f0)
grid on