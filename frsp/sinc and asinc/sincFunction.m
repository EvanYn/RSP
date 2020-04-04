clear; clc; close all;
%%
fLimit = 10;
f = linspace(-fLimit,fLimit,1001);
X = sinc(f);

figure(1)
subplot(2,1,1)
plot(f,X)
% sinc funtion 3 dB width
hline(1/sqrt(2),'r:')
vline([-0.89 0.89]/2)
xticks([-fLimit:-1 -0.89/2 0 0.89/2 1:fLimit])
text(-fLimit, 1/sqrt(2)+0.03, '1/sqrt(2)', 'Color', 'red')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('sinc funtion')
grid on

subplot(2,1,2)
plot(f,db(X))
% sinc function  first sidelobe peak 
hline(-13.26, 'r:')
text(-fLimit,-13.26 + 0.8,'-13.26 dB', 'Color', 'red')
ylim([-40 0])
xlabel('Frequency (Hz)')
ylabel('Amplitude (dB)')
title('sinc funtion (dB scale)')
grid on