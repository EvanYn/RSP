clear; clc; close all;
%%
f0 = 0.285;
N = 20;

x = exp(1j*2*pi*f0*(0:N-1));

figure(1)
subplot(2,1,1)
K1 = 20;
X1 = fftshift(fft(x,K1)/K1);
f1 = (0:K1-1)/K1 - 1/2;
stem(f1,abs(X1));
xlabel('f (Cycle/Sample)')
ylabel('|X(k)|')
title('Sampling of the DTFT of a 20-sample complex sinusoid by the DFT, K = 20')
grid on

subplot(2,1,2)
K2 = 48;
X2 = fftshift(fft(x,K2)/K2);
f2 = (0:K2-1)/K2 - 1/2;
stem(f2,abs(X2));
xlabel('f (Cycle/Sample)')
ylabel('|X(k)|')
title('Sampling of the DTFT of a 20-sample complex sinusoid by the DFT, K = 48')
grid on