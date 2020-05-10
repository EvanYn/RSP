clear; clc; close all;

%%
N = 16;
dl = 1/2;

theta_j = [-30 30 60];
JNR = [20 20 20];
Nj = length(theta_j);

fsp_j = dl*sind(theta_j);
Aj = exp(1j*2*pi*fsp_j.*(0:N-1)');

sigma_j = 10.^(JNR/20);

Rj = Aj*diag(sigma_j.^2)*Aj';
R = Rj + eye(N);

%%
theta = -90:0.01:90;
fsp = sind(theta)*dl;
A = exp(1j*2*pi*fsp.*(0:N-1)');

P1 = zeros(length(theta),1);
P_super = zeros(length(theta),1);

[V, D] = eig(R);
[~, I] = sort(diag(D));
Un = V(:,I(1:N-Nj));
P_music = zeros(length(theta),1);

for i = 1:length(theta)
    a = A(:,i);
    P1(i) = a'*R*a;
    P_super(i) = 1/(a'*(R\a));
    P_music(i) = 1/((a'*Un)*Un'*a);
end
P1 = abs(P1)/max(abs(P1));
P_super = abs(P_super)/max(abs(P_super));
P_music = abs(P_music)/max(abs(P_music));

%%
figure(1)
plot(theta,db(P1,'power'));
hold on
plot(theta,db(P_super,'power'));
plot(theta,db(P_music,'power'));
vline(theta_j)
xlabel('\theta (\circ)')
ylabel('PSD (dB)')
title('PSD of Jamming covariance matirx')
legend('conventional','super resolution', 'music')