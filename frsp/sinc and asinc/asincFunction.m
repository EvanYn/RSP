clear; clc; close all;
%%
f0 = 0;
N = 20;

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

figure(1)
plot(f, X);
xlabel('f (Cycle/Sample)')
ylabel('|X(f)|')
title('DTFT of a sampled constant-frequency complex exponential')
grid on

figure(2)
plot(f, db(X/max(X)));
xlabel('f (Cycle/Sample)')
ylabel('|X(f)|')
title('DTFT of a sampled constant-frequency complex exponential')
grid on