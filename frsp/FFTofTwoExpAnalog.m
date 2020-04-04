clear; clc; close all;
%%
F1 = 1;
F2 = 2.5;
F3 = 3;

fs = 10;
ts = 1/fs;
N = 20;

t = (0:N-1)*ts;
x = exp(1j*2*pi*F1*t) + exp(1j*2*pi*F2*t) + exp(1j*2*pi*F3*t);

figure(1)
K1 = 20;
f1 = ((0:K1-1)/K1 - 1/2)*fs;
X1 = fftshift(fft(x,K1)/K1);

K2 = 40;
f2 = ((0:K2-1)/K2 - 1/2)*fs;
X2 = fftshift(fft(x,K2)/K2);

K3 = 128;
f3 = ((0:K3-1)/K3 - 1/2)*fs;
X3 = fftshift(fft(x,K3)/K3);

plot(f1, abs(X1));
hold on
plot(f2, abs(X2));
plot(f3, abs(X3));
vline([F1 F2 F3])
xlabel('Frequency (Hz)')
ylabel('Amplitude')
grid on