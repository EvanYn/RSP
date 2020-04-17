clear; clc; close all;

%%
N = [16 32 64];
for i = 1:length(N)
    
    dl = 1/2;
    
    n = N(i) - 1;
    w = ones(n+1,1);
    w(1) = 1;
    
    for k = 1:n
        w(k+1) = w(k)*(n-(k-1))/k;
    end
    
    %%
    theta = -90:0.01:90;
    fsp = dl*sind(theta);
    A = exp(1j*2*pi*fsp.*(0:N(i)-1)');
    
    P = w'*A;
    P = abs(P)/max(abs(P));
    
    plot(fsp,P, 'DisplayName', ['N = ', num2str(N(i))])
    hold on
end
legend
grid on
xlabel('spatial frequency (Cycle/Sample)')
ylabel('Amplitude')
title('beampattern of binomial taper')