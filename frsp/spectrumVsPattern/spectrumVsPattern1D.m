clear; clc; close all;

%%
N = 16;
dl = 1/2;

theta_s = 0;
fsp_s = dl*sind(theta_s);
as = exp(1j*2*pi*fsp_s.*(0:N-1)');

%%
theta_j = [-30 30 60];
JNR = [10 20 30];
% theta_j = [-30];
% JNR = [10];
Nj = length(theta_j);

fsp_j = dl*sind(theta_j);
Aj = exp(1j*2*pi*fsp_j.*(0:N-1)');

sigma_j = db2pow(JNR);

Rj = Aj*diag(sigma_j)*Aj';

%%
R = Rj + eye(N);
w = R\as;

%%
theta = -90:0.01:90;
fsp = sind(theta)*dl;
A = exp(1j*2*pi*fsp.*(0:N-1)');

P1 = zeros(length(theta),1);
P2 = zeros(length(theta),1);

for i = 1:length(theta)
    a = A(:,i);
    P1(i) = 1/abs(a'*(R\a));
    P2(i) = abs(w'*a)^2;
end
P1 = P1/max(P1);
P2 = P2/max(P2);
%%
figure(1)
subplot(1,2,1)
plot(theta,db(P1,'power'))
xlim([-90 90])
xlabel('\theta (\circ)')
ylabel('P_{MVDR}(\theta) (dB)')
title('功率谱')
vline(theta_j)

subplot(1,2,2)
plot(theta,db(P2,'power'))
xlim([-90 90])
xlabel('\theta (\circ)')
ylabel('P(\theta)')
title('天线方向图')
vline(theta_j)