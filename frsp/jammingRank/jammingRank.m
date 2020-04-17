clear; clc; close all;

%%
N = 16;
dl = 1/2;

theta_j = [-30 30 60];
JNR = [10 20 30];
Nj = length(theta_j);

fsp_j = dl*sind(theta_j);
Aj = exp(1j*2*pi*fsp_j.*(0:N-1)');

sigma_j = 10.^(JNR/20);

Rj = Aj*diag(sigma_j.^2)*Aj';
R = Rj + eye(N);

%%
[V, D] = eig(R);
[eigval, I] = sort(abs(diag(D)),'descend');
figure(1)
plot(db(abs(eigval),'power'))
xlabel('index')
ylabel('eigen value (dB)')
title('eigen spectrum of interference covariance matirx')