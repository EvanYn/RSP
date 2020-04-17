clear; clc; close all;

%%
N = 3;
dl = 1/2;

theta_s = 0;
fsp_s = dl*sind(theta_s);
as = exp(1j*2*pi*fsp_s.*(0:N-1)');

theta_j = [-30 30 60];
JNR = [10 20 30];
% theta_j = [-30];
% JNR = [10];
Nj = length(theta_j);

fsp_j = dl*sind(theta_j);
Aj = exp(1j*2*pi*fsp_j.*(0:N-1)');

sigma_j = 10.^(JNR/20);

Rj = Aj*diag(sigma_j.^2)*Aj';
R = Rj + eye(N);

%% element space
w = R\as;

%%
theta = -90:0.01:90;
fsp = dl*sind(theta);
A = exp(1j*2*pi*fsp.*(0:N-1)');

P = w'*A;
P = abs(P)/max(abs(P));

%% plot
plot(theta,db(P,'power'))
vline(theta_s,'r:')
vline(theta_j,'g:')
ylim([-40 0])