clc;clear;close all;

%% Set Pramater
N = 16;
dl = [0.5 0.4 0.3];   % d/lambda

for i = 1:length(dl)
theta_s = 0;
ksi_s = dl(i)*sind(theta_s);    % spatial frequency of target signal
a_s = exp(1j*2*pi*ksi_s*(0:N-1)');    % steering vector of target signal

%% Compute weight
w = a_s;

%% Plot Beampattern
phi = -90:0.1:90;
ksi_phi = dl(i)*sind(phi);
a_phi = exp(1j*2*pi*ksi_phi.*(0:N-1)');

y = w'*a_phi;
y_disp = abs(y);
y_disp = y_disp/max(y_disp);

plot(phi,db(y_disp))
ylim([-60 0])
xlim([-90 90])
grid on
hold on
end

vline(theta_s,'r:')
xlabel('Angel of Arrival \theta (\circ)')
ylabel('Normalized Array Response (dB)')
title('阵元间距 d 固定，波长 \lambda 越短，阵列波束宽度越窄')

legendStrings = strings(1,length(dl));
for i = 1:length(dl)
%     legendStrings(i) = append("\lambda = ", string(1/dl(i)), " d");
    legendStrings(i) = append("d/\lambda = ", string(dl(i)));
end
legend(legendStrings)