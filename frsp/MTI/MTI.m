clear; clc; close all;

%%
f = linspace(-1.5, 1.5, 10001);
H2 = abs(1 - exp(-1j*2*pi*f));
H3 = abs((1 - exp(-1j*2*pi*f)).^2);

figure(1)
subplot(1,2,1)
plot(f,H2)
vline([-0.5, 0.5])
xlabel('Doppler Frequency (Cycle/sample)')
ylabel('|H(F_d)|')
title('Frequency response of basic MTI cancellers (two-pulse canceller)')

subplot(1,2,2)
plot(f,H3)
vline([-0.5, 0.5])
xlabel('Doppler Frequency (Cycle/sample)')
ylabel('|H(F_d)|')
title('Frequency response of basic MTI cancellers (three-pulse canceller)')