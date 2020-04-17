clear; clc; close all;

%%
N = 16;
dl = 1/2;

theta_j = [-30 30 60];
fsp_j = dl*sind(theta_j);
Aj = exp(1j*2*pi*fsp_j.*(0:N-1)');

JNR = [10 20 30];
sigma_j = 10.^(JNR/20);

Rj = Aj*diag(sigma_j.^2)*Aj';
R = Rj + eye(N);

%%
[V, D] = eig(R);
[eigval, I] = sort(abs(diag(D)),'descend');
figure(1)
plot(db(abs(eigval),'power'))

%%
theta = -90:0.01:90;
fsp = dl*sind(theta);
A = exp(1j*2*pi*fsp.*(0:N-1)');

P1 = zeros(length(theta),1);
P2 = zeros(length(theta),1);
for i = 1:length(theta)
    w = A(:,i);
    P1(i) = w'*R*w;
    P2(i) = 1/(w'*(R\w));
end

P1 = abs(P1)/max(abs(P1));
P2 = abs(P2)/max(abs(P2));

figure(2)
plot(theta,db(P1,'power'));
hold on
plot(theta,db(P2,'power'));