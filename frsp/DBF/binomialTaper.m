clear; clc; close all;

%%
N = [8 16 32];
for n = 1:length(N)
    
    dl = 1/2;
    
    w = ones(N(n),1);
    
    for i = 1:N(n)
        w(i) = nchoosek(N(n)-1,i-1);
    end
    
    %%
    theta = -90:0.01:90;
    fsp = dl*sind(theta);
    A = exp(1j*2*pi*fsp.*(0:N(n)-1)');
    
    P = w'*A;
    P = abs(P)/max(abs(P));
    
    plot(fsp,P, 'DisplayName', ['N =', num2str(N(n))])
    hold on
end
legend
grid on