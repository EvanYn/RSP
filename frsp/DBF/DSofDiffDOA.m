clc;clear;close all;

%% Set Pramater
N = 16;
dl = 0.5;   % d/lambda
theta_s = [0 30 60];

figure(1)
subplot(2,1,1)
for i = 1:length(theta_s)
ksi_s = dl*sind(theta_s(i));    % spatial frequency of target signal
a_s = exp(1j*2*pi*ksi_s*(0:N-1)');    % steering vector of target signal

%% Compute weight
w = a_s;

%% Plot Beampattern
phi = -90:0.1:90;
ksi_phi = dl*sind(phi);
a_phi = exp(1j*2*pi*ksi_phi.*(0:N-1)');

y = w'*a_phi;
y_disp = abs(y);
y_disp = y_disp/max(y_disp);

plot(ksi_phi,db(y_disp))
ylim([-40 0])
% xlim([-90 90])
grid on
hold on
end

vline(dl*sind(theta_s),'r:')
xlabel('spatial frequency \xi (Cycle/meter)')
ylabel('Normalized Array Response (dB)')
title('在正弦空间中，波束指向不影响波束宽度')

legendStrings = strings(1,length(theta_s));
for i = 1:length(theta_s)
    legendStrings(i) = append("\theta_s = ", string(theta_s(i)),"\circ");
end
legend(legendStrings,'Location','northwest')

%% degree space
subplot(2,1,2)

for i = 1:length(theta_s)
ksi_s = dl*sind(theta_s(i));    % spatial frequency of target signal
a_s = exp(1j*2*pi*ksi_s*(0:N-1)');    % steering vector of target signal

%% Compute weight
w = a_s;

%% Plot Beampattern
phi = -90:0.1:90;
ksi_phi = dl*sind(phi);
a_phi = exp(1j*2*pi*ksi_phi.*(0:N-1)');

y = w'*a_phi;
y_disp = abs(y);
y_disp = y_disp/max(y_disp);

plot(phi,db(y_disp))
ylim([-40 0])
xlim([-90 90])
grid on
hold on
end

vline(theta_s,'r:')
xlabel('Angel of Arrival \theta (degrees)')
ylabel('Normalized Array Response (dB)')
title('在角度空间中，波束指向影响波束宽度')

legendStrings = strings(1,length(theta_s));
for i = 1:length(theta_s)
    legendStrings(i) = append("\theta_s = ", string(theta_s(i)),"\circ");
end
legend(legendStrings,'Location','northwest')