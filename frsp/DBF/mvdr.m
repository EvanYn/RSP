clear; clc; close all;

%%
N = 16;
dl = 1/2;

theta_s = 0;
fsp_s = dl*sind(theta_s);
as = exp(1j*2*pi*fsp_s.*(0:N-1)');

theta_j = [-30 30 60];
Nj = length(theta_j);

fsp_j = dl*sind(theta_j);
Aj = exp(1j*2*pi*fsp_j.*(0:N-1)');

JNR = [10 20 30];
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

%% beam space
rj = rank(Rj);
[V, D] = eig(Rj);
[~,I] = sort(abs(diag(D)),'descend');
Ej = V(:,I(1:rj));

T = [as Ej];
R_tilde = T'*R*T;
as_tilde = T'*as;
w_tilde = R_tilde\as_tilde;

%%
A_tilde = T'*A;

P_tilde = w_tilde'*A_tilde;
P_tilde = abs(P_tilde)/max(abs(P_tilde));

%% plot
plot(theta,db(P,'power'))
hold on
plot(theta,db(P_tilde,'power'))
vline(theta_j)
legend('element space', 'beam space')