clear;clc;close all;

%%
N = 16;
M = 16;
dl = 1/2;
sigma = 1;

%% 目标
fsp_t = 0;
omega_t = 0.4;
xi_t = 20;

at = exp(1j*2*pi*fsp_t*(0:N-1)');
bt = exp(1j*2*pi*omega_t*(0:M-1)');
vt = kron(bt,at);

Rt = sigma^2*db2pow(xi_t)*(vt*vt');

%% 离散干扰目标
fsp_j = [-0.3 0.3];
omega_j = [0.3 -0.3];
xi_j = [20 25];
J = length(xi_j);
Vj = zeros(M*N,J);

for j = 1:J
    aj = exp(1j*2*pi*fsp_j(j)*(0:N-1)');
    bj = exp(1j*2*pi*omega_j(j)*(0:M-1)');
    vj = kron(bj,aj);
    Vj(:,j) = vj;
end

Xi_j = sigma^2*diag(db2pow(xi_j));
Rj = Vj*Xi_j*Vj';

%% 杂波
phi_c = -180:179;    % 杂波片角度
fsp_c = dl*sind(phi_c);   % 杂波片空域频率

beta = 1;   % 杂波折叠系数
omaga_c = beta*fsp_c;  % 杂波归一化多普勒

Nc = length(phi_c);   % 杂波片个数
Gt = zeros(Nc,1);   % 天线方向图
steering_angle = 0; % Angle of beam steering in degrees.
for k = 1:Nc
    Gt(k) = sum(  exp(1j*2*pi*dl*(0:N-1)*(sind(phi_c(k)) - sind(steering_angle)))  );
end
xi_c = abs(Gt);
CNR = 40;
xi_c = db2pow((CNR-db(sum(xi_c),'power')))*abs(Gt);

Vc = zeros(M*N,Nc); % 杂波空时二维导向矢量
for k = 1:Nc
    a = exp(1j*2*pi*fsp_c(k)*(0:N-1)');
    b = exp(1j*2*pi*omaga_c(k)*(0:M-1)');
    Vc(:,k) = kron(b,a);
end

Xi = sigma^2*diag(xi_c);
Rc = Vc*Xi*Vc';

%%
Ru = Rc + Rj + eye(M*N); % 杂波加目标加噪声协方差矩阵
w = Ru\vt;

%%
NI = 400;  % 用于匹配的空域通道数
NJ = 400;  % 用于匹配的多普勒通道数
fsp   = (0:NI-1)/NI - 1/2;
omega = (0:NJ-1)/NJ - 1/2;

P1 = zeros(NJ,NI); % MVDR 功率谱估计
P2 = zeros(NJ,NI); % 自适应方向图
for j = 1:NJ
    b = exp(1j*2*pi*omega(j)*(0:M-1)');
    for i = 1:NI
        a = exp(1j*2*pi*fsp(i)*(0:N-1)');
        v = kron(b,a); v = v/norm(v);
        P1(j,i) = 1/abs(v'*(Ru\v));
        P2(j,i) = abs(w'*v)^2;
    end
end
P1 = P1/max(P1,[],'all');
P2 = P2/max(P2,[],'all');

powerLowerBound = -100;
P1(db(P1,'power') < powerLowerBound) = db2pow(powerLowerBound);
P2(db(P2,'power') < powerLowerBound) = db2pow(powerLowerBound);

%%
figure(1)
subplot(1,2,1)
imagesc(fsp,omega,db(P1,'power'));colorbar;
shading interp;
xlabel('空间频率','FontName','Songti SC','FontSize',9)
ylabel('归一化多普勒频率','FontName','Songti SC','FontSize',9)

subplot(1,2,2)
imagesc(fsp,omega,db(P2,'power'));colorbar;
shading interp;
xlabel('空间频率','FontName','Songti SC','FontSize',9)
ylabel('归一化多普勒频率','FontName','Songti SC','FontSize',9)

%%
export_fig spectrumVsPattern.fig