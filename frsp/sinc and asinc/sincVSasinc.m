clear; clc; close all;
%% sinc
fsincLimit1 = 10;
fsinc1 = linspace(-fsincLimit1,fsincLimit1,10001);
Xsinc1 = sinc(fsinc1);

fsincLimit2 = 20;
fsinc2 = linspace(-fsincLimit2,fsincLimit2,20001);
Xsinc2 = sinc(fsinc2);

%% asinc
tw = 1;
f0 = 0;

% fs1 = 20 Hz
fs1 = 20;
N1 = tw.*fs1;

fasincLimit1 = 0.5;
fasinc1 = linspace(-fasincLimit1,fasincLimit1,10001);

Xasinc1 = zeros(length(fasinc1),1);

for i = 1:length(fasinc1)
    if sin(pi*(fasinc1(i)-f0)) == 0
        Xasinc1(i) = N1;
    else
        Xasinc1(i) = abs( sin(N1*pi*(fasinc1(i)-f0))/sin(pi*(fasinc1(i)-f0)) );
    end
end
Xasinc1 = Xasinc1/N1;

fasinc1 = fasinc1*fs1;

% fs2 = 40 Hz
fs2 = 40;
N2 = tw.*fs2;

fasincLimit2 = 0.5;
fasinc2 = linspace(-fasincLimit2,fasincLimit2,10001);

Xasinc2 = zeros(length(fasinc2),1);

for i = 1:length(fasinc2)
    if sin(pi*(fasinc2(i)-f0)) == 0
        Xasinc2(i) = N2;
    else
        Xasinc2(i) = abs( sin(N2*pi*(fasinc2(i)-f0))/sin(pi*(fasinc2(i)-f0)) );
    end
end
Xasinc2 = Xasinc2/N2;

fasinc2 = fasinc2*fs2;

%% plot
plot(fsinc2,db(abs(Xsinc2)),'DisplayName','sinc');
hold on
plot(fasinc1,db(abs(Xasinc1)),'DisplayName','asinc, fs = 20Hz');
plot(fasinc2,db(abs(Xasinc2)),'DisplayName','asinc, fs = 40Hz');
ylim([-40 0])
xlabel('Frequency (Hz)')
ylabel('Amplitude (dB)')
title('sinc and asinc funtion')
grid on
legend