clear; clc; close all;
%%
f0 = 0.285;
N = 20;

%% DTFT
fLimit = 0.5;
f = linspace(-fLimit,fLimit,10001);
X = zeros(length(f),1);

for i = 1:length(f)
    if sin(pi*(f(i)-f0)) == 0
        X(i) = N;
    else
        X(i) = abs( sin(N*pi*(f(i)-f0))/sin(pi*(f(i)-f0)) );
    end
end
X = X/N;

%% FFT
x = exp(1j*2*pi*f0*(0:N-1));

figure(1)
subplot(2,1,1)
K1 = 20;
X1 = fftshift(fft(x,K1)/N);
f1 = (0:K1-1)/K1 - 1/2;
stem(f1,abs(X1));
hold on
plot(f, X);
xlabel('f (Cycle/Sample)')
ylabel('|X(k)|')
title('Sampling of the DTFT of a 20-sample complex sinusoid by the DFT, K = 20')
grid on

subplot(2,1,2)
K2 = 48;
X2 = fftshift(fft(x,K2)/N);
f2 = (0:K2-1)/K2 - 1/2;
stem(f2,abs(X2));
hold on
plot(f, X);
xlabel('f (Cycle/Sample)')
ylabel('|X(k)|')
title('Sampling of the DTFT of a 20-sample complex sinusoid by the DFT, K = 48')
grid on