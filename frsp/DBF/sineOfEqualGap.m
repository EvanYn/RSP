clear; clc; close all;
%%
x = linspace(-180,180,10001);
y = sind(x);

plot(x,y)
sinValue = [0 0.2 0.8 1];
hline(sinValue)
vline(asind(sinValue))
xlim([-180 180])
xlabel('\theta (\circ)','interpreter','tex')
ylabel('sin(\theta)','interpreter','tex')
title('sin function')