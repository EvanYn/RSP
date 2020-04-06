clear; clc; close all;
%%
f0 = 0;

N = 20;
tw = [1 2];
fs = N./tw;

for n = 1:length(tw)
fLimit = 0.5;
f = linspace(-fLimit,fLimit,10000*n+1);

X = zeros(length(f),1);

for i = 1:length(f)
    if sin(pi*(f(i)-f0)) == 0
        X(i) = N;
    else
        X(i) = abs( sin(N*pi*(f(i)-f0))/sin(pi*(f(i)-f0)) );
    end
end
X = X/N;

F = f*fs(n);

figure(1)
subplot(2,1,1)
plot(F, X, 'DisplayName',['T = ',num2str(tw(n)),' s, f_s = ', num2str(fs(n)),' Hz']);
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('DTFT of a sampled constant-frequency complex exponential')
grid on
hold on
legend

subplot(2,1,2)
plot(F, db(X/max(X)), 'DisplayName',['T = ',num2str(tw(n)),' s, f_s = ', num2str(fs(n)),' Hz']);
% asinc function  first sidelobe peak 
hline(-13.19, 'r:')
text(-fLimit,-13.19 + 1.5,'-13.19 dB', 'Color', 'red')
ylim([-40 0])
xlabel('Frequency (Hz)')
ylabel('Amplitude (dB)')
title('DTFT of a sampled constant-frequency complex exponential')
grid on
hold on
legend
end